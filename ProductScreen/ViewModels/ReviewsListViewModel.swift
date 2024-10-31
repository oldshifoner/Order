//
//  ReviewsListViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 31.10.2024.
//

import Foundation

class ReviewsListViewModel {
    lazy var cellViewModels: [TableViewModel] = []
    lazy var reviews: [TableViewModel] = []
    
    var tableViewUpdate: (() -> Void)?
    var totalUpdate: ((Int) -> Void)?
    var clouser: ((String) -> Void)?
    
    public func showReviews(reviewList: MyReviewsList){
        cellViewModels = []
        
        reviewList.reviews.forEach { review in
            if !review.isWritten{
                cellViewModels.append(TableViewModel(type: .review(.init(
                    id: UUID().uuidString,
                    title: review.title,
                    size: review.size,
                    titleImage: review.titleImage,
                    anonymously: review.anonymously,
                    isWritten: review.isWritten))))
            }
        }
    }
}
