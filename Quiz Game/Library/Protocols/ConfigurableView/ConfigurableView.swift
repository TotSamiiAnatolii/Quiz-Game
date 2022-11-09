//
//  ConfigurableView.swift
//  Quiz Game
//
//  Created by APPLE on 01.09.2022.
//

import Foundation

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}
