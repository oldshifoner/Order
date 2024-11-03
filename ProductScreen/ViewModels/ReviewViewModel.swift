//
//  ReviewViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import Foundation

class ReviewViewModel {
    
    lazy var review: TableViewModel? = nil
    
    var tableViewUpdate: (() -> Void)?
    var totalUpdate: ((Int) -> Void)?
    var clouser: ((String) -> Void)?
    
    public func showReview() {
        
    }
}

