//
//  Walk+CoreDataProperties.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 12/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var comment: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var position: String?
    @NSManaged public var itinerary: String?
    @NSManaged public var mushList: NSObject?
    @NSManaged public var mushrooms: NSOrderedSet?

}

// MARK: Generated accessors for mushrooms
extension Walk {

    @objc(insertObject:inMushroomsAtIndex:)
    @NSManaged public func insertIntoMushrooms(_ value: Mush, at idx: Int)

    @objc(removeObjectFromMushroomsAtIndex:)
    @NSManaged public func removeFromMushrooms(at idx: Int)

    @objc(insertMushrooms:atIndexes:)
    @NSManaged public func insertIntoMushrooms(_ values: [Mush], at indexes: NSIndexSet)

    @objc(removeMushroomsAtIndexes:)
    @NSManaged public func removeFromMushrooms(at indexes: NSIndexSet)

    @objc(replaceObjectInMushroomsAtIndex:withObject:)
    @NSManaged public func replaceMushrooms(at idx: Int, with value: Mush)

    @objc(replaceMushroomsAtIndexes:withMushrooms:)
    @NSManaged public func replaceMushrooms(at indexes: NSIndexSet, with values: [Mush])

    @objc(addMushroomsObject:)
    @NSManaged public func addToMushrooms(_ value: Mush)

    @objc(removeMushroomsObject:)
    @NSManaged public func removeFromMushrooms(_ value: Mush)

    @objc(addMushrooms:)
    @NSManaged public func addToMushrooms(_ values: NSOrderedSet)

    @objc(removeMushrooms:)
    @NSManaged public func removeFromMushrooms(_ values: NSOrderedSet)

}
