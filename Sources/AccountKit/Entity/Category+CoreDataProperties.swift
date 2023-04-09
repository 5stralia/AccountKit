//
//  Category+CoreDataProperties.swift
//  AccountKit
//
//  Created by Hoju Choi on 2023/04/09.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String?

}

extension Category : Identifiable {

}
