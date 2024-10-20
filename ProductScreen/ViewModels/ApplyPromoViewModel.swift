//
//  ApplyPromoViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 27.10.2024.
//

import Foundation

class ApplyPromoViewModel {
    
    lazy var cellViewModels: [TableViewModel] = []
    lazy var secretPromocodes: [TableViewModel] = []
    
    var dataUpdated: (() -> Void)?
    var closure: ((String) -> Void)?
    
    var nextViewController: (()->())?
    
    public func initArray(){
        cellViewModels = []
        cellViewModels.append(TableViewModel(type: .enterSecretPromo(.init(errorLabel: nil))))
    }
    
    public func applyPromo(promoString: String) {
        
        guard let index = secretPromocodes.first(where: { value in
            switch value.type {
            case .secretPromo(let secretPromo):
                if secretPromo.title == promoString {
                    print(promoString + "enter")
                    print(secretPromo.title + "fact")
                    closure?(secretPromo.id)
                    nextViewController?()
                    return true
                }
            default:
                return false
            }
            return false
        })
        else {
            return
        }

        guard let index = cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .enterSecretPromo(_): return true
            default: return false
            }
        })
        else {return}
        
        let element = cellViewModels[index].type
        switch element {
        case .enterSecretPromo(let promo):
            let promo = promo
            cellViewModels.remove(at: index)
            cellViewModels.insert(.init(type: .enterSecretPromo(.init(errorLabel: "К сожалению, данного промокода не существует"))), at: index)
            dataUpdated?()
        default:break
        }
    }
}

