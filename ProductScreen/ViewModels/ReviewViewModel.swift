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
    var changeAnonymouslyClouser: ((Bool) -> Void)?
    
    public func showReview() {
        guard let review = self.review else{ return }
        cellViewModels.append(.init(type: .titleReview(review)))
        cellViewModels.append(.init(type: .evaluation(review)))
        //TableViewModel.ViewModelType.userPhotos(review)
        cellViewModels.append(.init(type: .plusMinusComment(review)))
        cellViewModels.append(.init(type: .sendReview(review)))
        initClouserForChangeEvaluation()
        initClouserForChangeAnonymously()
    }
    
    private func initClouserForChangeAnonymously(){
        self.changeAnonymouslyClouser = { [weak self] anonymously in
            
            guard let index = self?.getIndexSendReview() else {return}
            let element = self?.cellViewModels[index].type
            switch element {
            case .sendReview(let sendReview):
                let sendReview = sendReview
                self?.cellViewModels.remove(at: index)
                self?.cellViewModels.insert(.init(type: .sendReview(.init(id: sendReview.id, title: sendReview.title, size: sendReview.size, evaluation: sendReview.evaluation, titleImage: sendReview.titleImage, selfImages: sendReview.selfImages, advantages: sendReview.advantages, disadvantages: sendReview.disadvantages, comment: sendReview.comment, anonymously: anonymously, isWritten: sendReview.isWritten))), at: index)
            default:
                break
            }
        }
    }
    
    private func initClouserForChangeEvaluation(){
        self.clouser = { [weak self] evaluationIndex in
            guard let index = self?.getIndexEvaluation() else {return}
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
    
    private func getIndexTitleReview() -> Int?{
        guard let index = self.cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .titleReview(let titleReview):
                return true
            default:
                return false
            }
        }) else { return nil}
        return index
    }
    private func getIndexEvaluation() -> Int?{
        guard let index = self.cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .evaluation(let evaluation):
                return true
            default:
                return false
            }
        }) else { return nil }
        return index
    }
    private func getIndexUserPhotos() -> Int?{
        guard let index = self.cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .userPhotos(let userPhotos):
                return true
            default:
                return false
            }
        }) else { return nil }
        return index
    }
    private func getIndexPlusMinusComment() -> Int?{
        guard let index = self.cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .plusMinusComment(let plusMinusComment):
                return true
            default:
                return false
            }
        }) else { return nil}
        return index
    }
    private func getIndexSendReview() -> Int?{
        guard let index = self.cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .sendReview(let sendReview):
                return true
            default:
                return false
            }
        }) else { return nil}
        return index
    }
    
}

struct Evaluation {
    let name: String
    let index: Int
}

