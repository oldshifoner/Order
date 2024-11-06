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
    var evaluationUpdate: ((Int) -> Void)?
    var clouser: ((Int) -> Void)?
    
    public func showReview() {
        guard let review = self.review else{ return }
        cellViewModels.append(.init(type: .titleReview(review)))
        cellViewModels.append(.init(type: .evaluation(review)))
        //TableViewModel.ViewModelType.userPhotos(review)
        cellViewModels.append(.init(type: .plusMinusComment(review)))
        cellViewModels.append(.init(type: .sendReview(review)))
        changeEvaluation()
    }
    
    private func changeEvaluation(){
        
        self.clouser = { [weak self] evaluationIndex in
            guard let index = self?.cellViewModels.firstIndex(where: { value in
                switch value.type {
                case .evaluation(let evaluation):
                    return true
                default:
                    return false
                }
            }) else { return }
            let element = self?.cellViewModels[index].type
            switch element {
            case .evaluation(let evaluation):
                let evaluation = evaluation
                self?.cellViewModels.remove(at: index)
                self?.cellViewModels.insert(.init(type: .evaluation(.init(id: evaluation.id, title: evaluation.title, size: evaluation.size, evaluation: self?.getObjectEvaluation(index: evaluationIndex), titleImage: evaluation.titleImage, selfImages: evaluation.selfImages, advantages: evaluation.advantages, disadvantages: evaluation.disadvantages, comment: evaluation.comment, anonymously: evaluation.anonymously, isWritten: evaluation.isWritten))), at: index)
                self?.evaluationUpdate?(index)
            default:
                break
            }
        }
        
    }
    private func getObjectEvaluation(index: Int) -> Evaluation{
        return Evaluation(name: evaluationArray[index], index: index + 1)
    }
}

struct Evaluation {
    let name: String
    let index: Int
}

