//
//  ReviewViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import Foundation

class ReviewViewModel {
    
    lazy var review: TableViewModel.ViewModelType.Review? = nil
    lazy var cellViewModels: [TableViewModel] = []
    lazy var evaluationArray: [String] = ["Ужасно","Плохо","Нормально","Хорошо","Отлично"]
    
    var tableViewUpdate: (() -> Void)?
    var totalUpdate: ((Int) -> Void)?
    var clouser: ((String) -> Void)?
    
    public func showReview() {
        guard let review = self.review else{ return }
        cellViewModels.append(.init(type: .titleReview(review)))
        cellViewModels.append(.init(type: .evaluation(review)))
        //TableViewModel.ViewModelType.userPhotos(review)
        cellViewModels.append(.init(type: .plusMinusComment(review)))
        cellViewModels.append(.init(type: .sendReview(review)))
    }
    
    public func changeEvaluation(){
        
    }
    
}

struct Evaluation {
    let name: String
    let index: Int
}

