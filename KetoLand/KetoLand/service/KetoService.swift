//
//  KetoService.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/9/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

typealias RestaurantListHandler = (([Place]?) -> Void)?

class KetoService {
    static let shared = KetoService()
    private init() {}
    
    var managedObjectContext: NSManagedObjectContext?
    var places = [Place]()
    
    func loadRestaurants(around location: CLLocation? = nil, completionHandler: RestaurantListHandler) {
        var params = [String: Any]()
        var lat: CLLocationDegrees
        var lng: CLLocationDegrees
        
        if let location = location {
            lat = location.coordinate.latitude
            lng = location.coordinate.longitude
            params["lat"] = lat
            params["lon"] = lng
        }
        else {
            params["q"] = 80231
        }
        
        params["radius"] = 10000
        params["start"] = 1
        params["count"] = 100
        
        RESTService.execute(endPoint: "https://developers.zomato.com/api/v2.1/search", forType: .get, withParams: params) { [ weak self] (json, error) in
            guard let json = json as? NSDictionary, let jsonPlaces = json["restaurants"] as? NSArray else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: jsonPlaces, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                if let jsonStr = String(data: data, encoding: .utf8) {
                    print(jsonStr)
                }
                
                let decoder = JSONDecoder()
                self?.places = try decoder.decode([Place].self, from: data)
                
                completionHandler?(self?.places)
            }
            catch let error as NSError {
                print(error.localizedDescription)
                completionHandler?(nil)
            }
        }
    }
    
    func getRestaurantList() -> [Restaurant]? {
        let request: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        do {
            let results = try managedObjectContext?.fetch(request)
            return results
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func deleteRestaurantList() {
        let request: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try managedObjectContext?.execute(deleteRequest)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func saveCurrentList(withName name: String?) {
        guard
            let managedObjectContext = managedObjectContext,
            let name = name, !name.isEmpty,
            !places.isEmpty
        else { return }
        
        let privateContext = CoreDataStack().persistentContainer.newBackgroundContext()
        
        var restaurants = [Restaurant]()
        do {
            for place in places {
                let restaurant = Restaurant(context: privateContext)
                restaurant.name = place.placeInfo.name
                restaurant.address = place.placeInfo.location.address
                restaurant.website = place.placeInfo.website
                
                if let url = URL(string: place.placeInfo.imageURL), let imageData = NSData(contentsOf: url) {
                    restaurant.image = imageData
                }
                
                restaurants.append(restaurant)
            }
            
            let storedLocation = StoredLocation(context: privateContext)
            storedLocation.name = name
            storedLocation.addToRestaurants(NSSet(array: restaurants))
            
            try privateContext.save()
        }
        catch let error {
            print("Save failed: \(error.localizedDescription)")
        }
    }
}
