//
//  CancellationReason.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 12.12.2024.
//

import Foundation

struct CancellationReasonModel: Hashable{
    let id: UUID = UUID()
    let title: String
    var isSelected: Bool
    var isOther: Bool
    var comment: String?
    
    init(title: String, isSelected: Bool = false, isOther: Bool = false) {
        self.title = title
        self.isSelected = isSelected
        self.isOther = isOther
    }
}
