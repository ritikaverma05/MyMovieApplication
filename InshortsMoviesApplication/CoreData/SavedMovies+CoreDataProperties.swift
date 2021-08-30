//
//  SavedMovies+CoreDataProperties.swift
//  
//
//  Created by RITIKA VERMA on 16/08/21.
//
//

import Foundation
import CoreData


extension SavedMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedMovies> {
        return NSFetchRequest<SavedMovies>(entityName: "SavedMovies")
    }

    @NSManaged public var id: Int32
    @NSManaged public var posterPath: String?
    @NSManaged public var title: NSObject?
    @NSManaged public var release_date: String?

}
