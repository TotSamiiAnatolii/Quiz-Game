//
//  Category+CoreDataClass.swift
//  Quiz Game
//
//  Created by APPLE on 16.09.2022.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    
    public var progressCategory: Float {
        
        var progress: Float = 0
        
        guard let categoryType = self.categoryType?.allObjects as? [CategoryType] else {return 0}
        
        categoryType.forEach { categoryType in
            progress += categoryType.progressCategoryType
        }
        return progress / Float(categoryType.count)
    }
}
