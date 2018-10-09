//
//  StoredLocation+CoreDataProperties.swift
//  KetoLand
//
//  Created by Jason Sanchez on 10/9/18.
//  Copyright © 2018 Jason Sanchez. All rights reserved.
//
//

import Foundation
import CoreData


extension StoredLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredLocation> {
        return NSFetchRequest<StoredLocation>(entityName: "StoredLocation")
    }

    @NSManaged public var name: String?
    @NSManaged public var restaurants: NSSet?

}

// MARK: Generated accessors for restaurants
extension StoredLocation {

    @objc(addRestaurantsObject:)
    @NSManaged public func addToRestaurants(_ value: Restaurant)

    @objc(removeRestaurantsObject:)
    @NSManaged public func removeFromRestaurants(_ value: Restaurant)

    @objc(addRestaurants:)
    @NSManaged public func addToRestaurants(_ values: NSSet)

    @objc(removeRestaurants:)
    @NSManaged public func removeFromRestaurants(_ values: NSSet)

}
