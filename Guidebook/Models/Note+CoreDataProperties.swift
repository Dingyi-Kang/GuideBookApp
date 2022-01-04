//
//  Note+CoreDataProperties.swift
//  Guidebook
//
//  Created by OSU App Center on 6/28/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var place: Place?

}

extension Note : Identifiable {

}
