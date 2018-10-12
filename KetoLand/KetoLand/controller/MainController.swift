//
//  MainController.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/8/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//

import UIKit
import CoreLocation

class MainController: UIViewController {
    
    private var userLocation: CLLocation?
    private var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        findUserLocation()
    }
    
    @IBAction func didTapRestaurantAroundMe(_ sender: UIButton) {
        
    }
    
    private func findUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self as! CLLocationManagerDelegate
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        
        print(CLLocationManager.authorizationStatus().rawValue)
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRestaurant" {
            let destination = segue.destination as! RestaurantController
            destination.userLocation = userLocation
        }
    }
}

extension MainController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        userLocation = lastLocation
        
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
