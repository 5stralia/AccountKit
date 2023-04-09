//
//  Item+CoreDataProperties.swift
//  AccountKit
//
//  Created by Hoju Choi on 2023/04/09.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var amount: Double
    @NSManaged public var note: String?
    @NSManaged public var category: String?

}

extension Item : Identifiable {

}

extension Item {
    func toAccountItem() -> AccountItem {
        return AccountItem(
            title: self.title!,
            timestamp: self.timestamp!,
            amount: self.amount,
            category: self.category!,
            note: self.note!
        )
    }
}
