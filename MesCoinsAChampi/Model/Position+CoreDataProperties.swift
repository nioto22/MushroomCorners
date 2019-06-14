//
//  Position+CoreDataProperties.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//
//

import Foundation
import CoreData


extension Position {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Position> {
        return NSFetchRequest<Position>(entityName: "Position")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var mush: Mush?
    @NSManaged public var walk: Walk?

}
