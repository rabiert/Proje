//
//  BookItem+CoreDataProperties.swift
//  Proje
//
//  Created by Rabia on 23.05.2022.
//
//

import Foundation
import CoreData


extension BookItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookItem> {
        return NSFetchRequest<BookItem>(entityName: "BookItem")
    }

    @NSManaged public var bookName: String?
    @NSManaged public var authorName: String?

}

extension BookItem : Identifiable {

}
