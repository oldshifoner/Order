//
//  ViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 22.10.2024.
//

import Foundation

class ViewModel {

    lazy var cellViewModels: [TableViewModel] = []
    lazy var secretPromocodes: [TableViewModel] = []
    
    var tableViewUpdate: (() -> Void)?
    var totalUpdate: ((Int) -> Void)?
    var clouser: ((String) -> Void)?
  
    public func showOrder(order: Order){
        cellViewModels = []
        
        clouser = {string in
            self.addSecretPromoInArray(id: string)
            self.tableViewUpdate?()
        }
        
        order.secretPromocodes.forEach { secretPromo in
            secretPromocodes.append(TableViewModel(type: .secretPromo(.init(
                title: secretPromo.title,
                percent: secretPromo.percent,
                info: secretPromo.info ?? "",
                isActive: secretPromo.active,
                id: UUID().uuidString,
                applied: secretPromo.applied ?? false))))
        }
        cellViewModels.append(TableViewModel.init(type: .info(.init(
            title: order.screenTitle,
            info: "На один товар можно применить только один промокод"))))
        
        cellViewModels.append(TableViewModel(type: .applyPromo(.init())))
        
        order.promocodes.forEach { promo in
            cellViewModels.append(TableViewModel(type: .promo(.init(
                title: promo.title,
                percent: promo.percent,
                info: promo.info ?? "",
                isActive: promo.active,
                id: UUID().uuidString))))
        }
        
        secretPromocodes.forEach { secretPromo in
            if checkAppiedPromo(secretPromo: secretPromo){
                cellViewModels.append(secretPromo)
            }
        }
        
        cellViewModels.append(TableViewModel(type: .total(.init(
            currentPrice: "25 000000000000000000000000000000001000000000000000000000000000000001 Р",
            discount: "-5 000 P",
            promocodes: "-5 0004536453453453453435434535435463453645345634534563456345634563456345345636453654 P",
            paymentMethod: "-5 000 P",
            totalPrice: "1900054375357353435463456345345345345000000000000000000000000000000001000000000000000000000000000000001 P"))))
    }
    
    private func checkAppiedPromo(secretPromo: TableViewModel) -> Bool {
        switch secretPromo.type{
        case .secretPromo(let secretPromo):
            return secretPromo.applied
        default: break
        }
        return false
    }
    
    public func addSecretPromoInArray(id: String) {
        guard let element = secretPromocodes.first(where: { value in
            switch value.type {
            case .secretPromo(let promo):
                if promo.id == id {
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
        cellViewModels.insert(element, at: 2)
    }
    
    public func togglePromo(value: Bool, id: String) {
        guard let index = cellViewModels.firstIndex(where: { value in
            switch value.type {
            case .promo(let promo):
                if promo.id == id {
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
        let element = cellViewModels[index].type
        switch element {
        case .promo(let promo):
            let promo = promo
            cellViewModels.remove(at: index)
            cellViewModels.insert(.init(type: .promo(.init(title: promo.title,
                                                           percent: promo.percent,
                                                           info: promo.info,
                                                           isActive: value,
                                                           id: id))), at: index)
            totalUpdate?(cellViewModels.count - 1)
        default:
            break
            
        }
        
    }
}

struct TableViewModel {
    enum ViewModelType {
        struct Promo {
            let id : String
            let title: String
            let percent: String
            let info: String
            let isActive: Bool
            
            init(title: String,
                 percent: String,
                 info: String,
                 isActive: Bool,
                 id: String) {
                self.title = title
                self.percent = percent
                self.info = info
                self.isActive = isActive
                self.id = id
            }
        }
        
        struct SecretPromo {
            let id : String
            let title: String
            let percent: String
            let info: String
            let isActive: Bool
            let applied: Bool
            
            init(title: String,
                 percent: String,
                 info: String,
                 isActive: Bool,
                 id: String,
                 applied: Bool) {
                self.title = title
                self.percent = percent
                self.info = info
                self.isActive = isActive
                self.id = id
                self.applied = applied
            }
        }
        
        struct ApplyPromo{}
        struct Total{
            let currentPrice: String
            let discount: String
            let promocodes: String
            let paymentMethod: String
            let totalPrice: String
            
            init(currentPrice: String, discount: String, promocodes: String, paymentMethod: String, totalPrice: String) {
                self.currentPrice = currentPrice
                self.discount = discount
                self.promocodes = promocodes
                self.paymentMethod = paymentMethod
                self.totalPrice = totalPrice
            }
        }
        
        struct EnterSecretPromo{
            let errorLabel: String?
        }
        
        struct TitleInfo {
            let title: String
            let info: String
        }

        case info(TitleInfo)
        case promo(Promo)
        case applyPromo(ApplyPromo)
        case total(Total)
        case secretPromo(SecretPromo)
        case enterSecretPromo(EnterSecretPromo)
    }
    
    var type: ViewModelType
}
