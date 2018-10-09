//
//  LocationService.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/9/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    static let shared = LocationService()
    private override init() {}
    
    var locationUpdateHandler: ((Bool, CLLocation?) -> Void)?
    
    var userLocation: CLLocation?
    let locationManager = CLLocationManager()
    
    func findUserLocation() {
        
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
