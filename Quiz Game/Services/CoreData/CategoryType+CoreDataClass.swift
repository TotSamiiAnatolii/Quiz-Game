//
//  CategoryType+CoreDataClass.swift
//  Quiz Game
//
//  Created by APPLE on 04.10.2022.
//
//

import Foundation
import CoreData

@objc(CategoryType)
public class CategoryType: NSManagedObject {
    
    public var progressCategoryType: Float {
        
        guard var actualQuizSession = self.actualQuizSession?.allObjects as? [ActualQuizSession] else {return 0}
        
        actualQuizSession.sort { $0.startDate > $1.startDate }
        
        return actualQuizSession.first?.progressForGame ?? 0
    }
}
