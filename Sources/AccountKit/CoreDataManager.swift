//
//  CoreDataManager.swift
//  AccountKit
//
//  Created by Hoju Choi on 2023/04/09.
//

import CoreData
import Foundation

final class CoreDataManager {
    let container = NSPersistentContainer(name: "AccountKit")
    var context: NSManagedObjectContext {
        self.container.viewContext
    }
    
    init() {
        self.container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Can not load: \(String(describing: error))")
            }
        }
    }
    
    func addItem(
        title: String,
        timestamp: Date,
        amount: Double,
        category: String,
        note: String
    ) throws {
        let _item = Item(context: self.context)
        _item.title = title
        _item.timestamp = timestamp
        _item.note = note
        _item.amount = amount
        _item.category = category
        
        try self.context.save()
    }
    
    func delete(_ item: Item) throws {
        self.context.delete(item)
        try self.context.save()
    }
    
    func update(
        _ item: Item,
        title: String? = nil,
        timestamp: Date? = nil,
        note: String? = nil,
        amount: Double? = nil,
        category: String? = nil
    ) throws {
        if let title {
            item.title = title
        }
        
        if let timestamp {
            item.timestamp = timestamp
        }
        
        if let note {
            item.note = note
        }
        
        if let amount {
            item.amount = amount
        }
        
        if let category {
            item.category = category
        }
        
        try self.context.save()
    }
    
    func search(
        title: String?,
        dateRange: (start: Date, end: Date)?,
        category: String?,
        amountRange: (start: Double, end: Double)?
    ) throws -> [Item] {
        var predicates: [NSPredicate] = []
        
        if let title {
            let titlePredicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Item.title), title)
            predicates.append(titlePredicate)
        }
        
        if let dateRange {
            let datePredicate = NSPredicate(
                format: "%K BETWEE {%@, %@}",
                #keyPath(Item.timestamp),
                dateRange.start as NSDate,
                dateRange.end as NSDate
            )
            predicates.append(datePredicate)
        }
        
        if let category {
            let categoryPredicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
            predicates.append(categoryPredicate)
        }
        
        if let amountRange {
            let amountPredicate = NSPredicate(
                format: "%K BETWEEN {%@, %@}",
                #keyPath(Item.amount),
                amountRange.start,
                amountRange.end
            )
            predicates.append(amountPredicate)
        }
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.predicate = predicate
        
        return try self.context.fetch(request)
    }
    
    func fetchAllCategories() throws -> [Category] {
        return try self.context.fetch(Category.fetchRequest())
    }
    
    func addCategory(title: String) throws {
        let _category = Category(context: self.context)
        _category.title = title
        
        try self.context.save()
    }
    
    func delete(_ category: Category) throws {
        self.context.delete(category)
        try self.context.save()
    }
}
