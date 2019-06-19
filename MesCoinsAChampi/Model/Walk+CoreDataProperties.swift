//
//  Walk+CoreDataProperties.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var distance: Double
    @NSManaged public var duration: Int16
    @NSManaged public var timestamp: Date
    @NSManaged public var title: String?
    @NSManaged public var mushrooms: NSOrderedSet?
    @NSManaged public var positions: NSOrderedSet?

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

// MARK: Generated accessors for position
extension Walk {

    @objc(insertObject:inPositionAtIndex:)
    @NSManaged public func insertIntoPositions(_ value: Position, at idx: Int)

    @objc(removeObjectFromPositionAtIndex:)
    @NSManaged public func removeFromPositions(at idx: Int)

    @objc(insertPosition:atIndexes:)
    @NSManaged public func insertIntoPositions(_ values: [Position], at indexes: NSIndexSet)

    @objc(removePositionAtIndexes:)
    @NSManaged public func removeFromPositions(at indexes: NSIndexSet)

    @objc(replaceObjectInPositionAtIndex:withObject:)
    @NSManaged public func replacePositions(at idx: Int, with value: Position)

    @objc(replacePositionAtIndexes:withPosition:)
    @NSManaged public func replacePositions(at indexes: NSIndexSet, with values: [Position])

    @objc(addPositionsObject:)
    @NSManaged public func addToPositions(_ value: Position)

    @objc(removePositionObject:)
    @NSManaged public func removeFromPositions(_ value: Position)

    @objc(addPosition:)
    @NSManaged public func addToPositions(_ values: NSOrderedSet)

    @objc(removePosition:)
    @NSManaged public func removeFromPositions(_ values: NSOrderedSet)

}
