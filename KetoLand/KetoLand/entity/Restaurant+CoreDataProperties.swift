//
//  Restaurant+CoreDataProperties.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/9/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var address: String?
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var website: String?
    @NSManaged public var storedLocation: StoredLocation?

}
