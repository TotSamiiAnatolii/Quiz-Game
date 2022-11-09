//
//  ModelSelectedCategoryView.swift
//  Quiz Game
//
//  Created by APPLE on 01.09.2022.
//

import Foundation

struct ModelSelectedCategoryView {
    
    let onBackButton: (()->())?
}

struct ModelSelectedCategoryCell {
    
    let nameType: String
    let countQuestion: Int
    let state: Float
}
