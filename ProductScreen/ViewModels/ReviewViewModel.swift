//
//  ReviewViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import Foundation

class ReviewViewModel {
    
    public lazy var cellViewModels: [TableViewModel] = []
    public lazy var review: TableViewModel.ViewModelType.Review? = nil
    
    private lazy var evaluationArray: [String] = ["Ужасно","Плохо","Нормально","Хорошо","Отлично"]
    private var photosLocal: [String] = ["media1","media2","media3","media4","media5","media6","media7"]
    
    var tableViewUpdate: (() -> Void)?
    var evaluationUpdate: ((Int) -> Void)?
    var imagesCellUpdate: ((Int) -> Void)?
    var clouser: ((Int) -> Void)?
    var changeAnonymouslyClouser: ((Bool) -> Void)?
    var addPhotoClouser: ((Int) -> Void)?
    var deletePhotoClouser: ((Int) -> Void)?
    
    public func showReview() {
        guard let review = self.review else{ return }
        cellViewModels.append(.init(type: .titleReview(review)))
        cellViewModels.append(.init(type: .evaluation(review)))
        cellViewModels.append(.init(type: .userPhotos(review)))
        cellViewModels.append(.init(type: .plusMinusComment(review)))
        cellViewModels.append(.init(type: .sendReview(review)))
        initClouserForChangeEvaluation()
        initClouserForChangeAnonymously()
        initClouserForAddPhoto()
        initClouserForDeletePhoto()
    }
    
    private func initClouserForDeletePhoto(){
        self.deletePhotoClouser = { [weak self] indexPhoto in
            
            guard let index = self?.getIndexUserPhotos() else {return}
            let element = self?.cellViewModels[index].type
            switch element {
            case .userPhotos(let userPhotos):
                let userPhotos = userPhotos
                self?.cellViewModels.remove(at: index)
                self?.cellViewModels.insert(.init(type: .userPhotos(.init(id: userPhotos.id, title: userPhotos.title, size: userPhotos.size, evaluation: userPhotos.evaluation, titleImage: userPhotos.titleImage, selfImages: self?.deletePhotoInArrayUserPhotos(selfImages: userPhotos.selfImages,indexPhoto: indexPhoto), advantages: userPhotos.advantages, disadvantages: userPhotos.disadvantages, comment: userPhotos.comment, anonymously: userPhotos.anonymously, isWritten: userPhotos.isWritten))), at: index)
                self?.imagesCellUpdate?(index)
            default:
                break
            }
        }
    }
    
    private func deletePhotoInArrayUserPhotos(selfImages: [String]?, indexPhoto: Int) -> [String]? {
        guard var selfImages else{
            return nil
        }
        
        selfImages.remove(at: indexPhoto)
        if selfImages.count == 0 { return nil }
        return selfImages
    }
    
    private func initClouserForAddPhoto(){
        self.addPhotoClouser = { [weak self] indexPhoto in
            
            guard let index = self?.getIndexUserPhotos() else {return}
            let element = self?.cellViewModels[index].type
            switch element {
            case .userPhotos(let userPhotos):
                let userPhotos = userPhotos
                self?.cellViewModels.remove(at: index)
                self?.cellViewModels.insert(.init(type: .userPhotos(.init(id: userPhotos.id, title: userPhotos.title, size: userPhotos.size, evaluation: userPhotos.evaluation, titleImage: userPhotos.titleImage, selfImages: self?.addPhotoInArraySelfImages(selfImages: userPhotos.selfImages, index: indexPhoto), advantages: userPhotos.advantages, disadvantages: userPhotos.disadvantages, comment: userPhotos.comment, anonymously: userPhotos.anonymously, isWritten: userPhotos.isWritten))), at: index)
                self?.imagesCellUpdate?(index)
            default:
                break
            }
        }
    }
    
    private func addPhotoInArraySelfImages(selfImages: [String]?, index: Int) -> [String]{
        guard var selfImages else{
            var selfImages: [String] = []
            selfImages.append(self.photosLocal[0])
            return selfImages
        }
        
        selfImages.append(self.photosLocal[index])
        return selfImages
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

