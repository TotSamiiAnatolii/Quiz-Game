//
//  CategoryForGame+CoreDataProperties.swift
//  Quiz Game
//
//  Created by APPLE on 15.10.2022.
//
//

import Foundation
import CoreData


extension CategoryForGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryForGame> {
        return NSFetchRequest<CategoryForGame>(entityName: "CategoryForGame")
    }

    @NSManaged public var category: CategoryType

}

extension CategoryForGame : Identifiable {

}
