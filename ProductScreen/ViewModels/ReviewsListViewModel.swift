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
    
    public func getCellReviewViewModels(index: Int) -> TableViewModel.ViewModelType.Review? {
        
        let element = cellViewModels[index].type
        switch element {
        case .review(let review):
            let review = review
            return TableViewModel.ViewModelType.Review(
                id: review.id,
                title: review.title,
                size: review.size,
                evaluation: review.evaluation,
                titleImage: review.titleImage,
                selfImages: ["media1","media2","media3","media4"],
                //selfImages: review.selfImages,
                advantages: review.advantages,
                disadvantages: review.disadvantages,
                comment: review.comment,
                anonymously: review.anonymously,
                isWritten: review.isWritten)
        default:
            return nil
        }
    }
    
    public func showReviews(reviewList: MyReviewsList){
        cellViewModels = []
        
        reviewList.reviews.forEach { review in
            if !review.isWritten{
                cellViewModels.append(TableViewModel(type: .review(.init(
                    id: UUID().uuidString,
                    title: review.title,
                    size: review.size,
                    evaluation: review.evaluation,
                    titleImage: review.titleImage,
                    selfImages: review.selfImages,
                    advantages: review.advantages,
                    disadvantages: review.disadvantages,
                    comment: review.comment,
                    anonymously: review.anonymously,
                    isWritten: review.isWritten))))
            }
        }
    }
}
