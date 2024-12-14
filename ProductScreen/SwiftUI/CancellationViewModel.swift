//
//  CancellationViewModel.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 12.12.2024.
//

import SwiftUI

class CancellationViewModel: ObservableObject {
    @Published var reasons: [CancellationReasonModel] = [
        CancellationReasonModel(title: "Не подходит дата получения"),
        CancellationReasonModel(title: "Часть товаров из заказа былa отменена"),
        CancellationReasonModel(title: "Не получилось применить скидку или промокод"),
        CancellationReasonModel(title: "Хочу изменить заказ и оформить заново"),
        CancellationReasonModel(title: "Нашелся товар дешевле"),
        CancellationReasonModel(title: "Другое", isOther: true)
    ]
    
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    @Published var showNotification: Bool = false
    @Published var selectedOtherReason: Bool = false

    public func selectReason(_ reason: CancellationReasonModel) {
        for index in reasons.indices {
            if reasons[index].id == reason.id{
                reasons[index].isSelected = true
                selectedOtherReason = reasons[index].isOther
            }
            else {
                reasons[index].isSelected = false
            }
        }
    }

    public func submitCancellation() {
        if reasons.first(where: { $0.isSelected }) == nil {
            showError = true
        } else {
            showError = false
            isLoading = true
                        
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isLoading = false
                self.showNotification = true
                self.resetAllReason()

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.showNotification = false
                }
            }
        }
    }
    
    private func resetAllReason(){
        for index in reasons.indices {
            reasons[index].isSelected = false
            reasons[index].comment = nil
            selectedOtherReason = false
        }
    }
}
