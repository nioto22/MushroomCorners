//
//  Mush+CoreDataProperties.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 14/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//
//

import Foundation
import CoreData


extension Mush {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mush> {
        return NSFetchRequest<Mush>(entityName: "Mush")
    }

    @NSManaged public var comment: String?
    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var mushroomType: String?
    @NSManaged public var pictures: String?
    @NSManaged public var title: String?
    @NSManaged public var walk: Walk?
    @NSManaged public var position: Position?

}
