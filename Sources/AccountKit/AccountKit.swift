//
//  AccountKit.swift
//  AccountKit
//
//  Created by Hoju Choi on 2023/04/09.
//

import Foundation

final public class AccountDataManager {
    let coreDataManager = CoreDataManager()
    
    public func addItem(
        title: String,
        timestamp: Date,
        amount: Double,
        category: String,
        note: String
    ) throws {
        try self.coreDataManager.addItem(title: title, timestamp: timestamp, amount: amount, category: category, note: note)
    }
    
    public func delete(_ item: Item) throws {
        try self.coreDataManager.delete(item)
    }
    
    public func update(
        _ item: Item,
        title: String? = nil,
        timestamp: Date? = nil,
        note: String? = nil,
        amount: Double? = nil,
        category: String? = nil
    ) throws {
        try self.coreDataManager.update(
            item,
            title: title,
            timestamp: timestamp,
            note: note,
            amount: amount,
            category: category
        )
    }
    
    public func search(
        title: String?,
        dateRange: (start: Date, end: Date)?,
        category: String?,
        amountRange: (start: Double, end: Double)?
    ) throws -> [Item] {
        return try self.coreDataManager.search(
            title: title,
            dateRange: dateRange,
            category: category,
            amountRange: amountRange
        )
    }
    
    public func fetchAllCategories() throws -> [Category] {
        return try self.coreDataManager.fetchAllCategories()
    }
    
    public func addCategory(title: String) throws {
        try self.coreDataManager.addCategory(title: title)
    }
    
    public func delete(_ category: Category) throws {
        try self.coreDataManager.delete(category)
    }
}
