//
//  Note+CoreDataProperties.swift
//  Modulo7_Practica2
//
//  Created by Ricardo Rosales Romero on 10/10/23.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var idNote: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var userId: Int16

}

extension Note : Identifiable {

}
