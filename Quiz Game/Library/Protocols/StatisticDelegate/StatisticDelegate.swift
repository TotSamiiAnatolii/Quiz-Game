//
//  StatisticDelegate.swift
//  Quiz Game
//
//  Created by APPLE on 13.09.2022.
//

import Foundation

protocol StatisticDelegate {
    
    func deleteAllCategoryProgress()
    
    func deleteOneCategoryProgress(index: Int)
}
