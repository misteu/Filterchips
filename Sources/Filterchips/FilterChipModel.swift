//
//  FilterChipModel.swift
//  
//
//  Created by skrr on 02.01.23.
//

import Foundation

public struct FilterChipModel {
    let title: String
    let isSelected: Bool

    let tapHandler: ((Bool) -> Void)?

    public init(title: String, isSelected: Bool = false, tapHandler: ((Bool) -> Void)?) {
        self.title = title
        self.isSelected = isSelected
        self.tapHandler = tapHandler
    }
}
