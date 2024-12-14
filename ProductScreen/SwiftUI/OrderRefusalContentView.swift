//
//  CancellationView.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 12.12.2024.
//

import SwiftUI

struct OrderRefusalContentView: View {
    @StateObject var viewModel: CancellationViewModel = CancellationViewModel()
        
    var body: some View {
        ZStack {
            VStack() {
                Spacer()
                    .frame(height: 26)
                
                if viewModel.showError {
                    Text("Пожалуйста, выберите причину")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                ForEach(viewModel.reasons, id: \.self) { reason in
                    @State var reason = reason
                    ButtonReasonView(reason: $reason, viewModel: viewModel)
                }
                if viewModel.selectedOtherReason {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Опишите проблему",text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 16)
                    }
                }
                Text("Обычно деньги сразу возвращаются на карту. В некоторых случаях это может занять до 3 рабочих дней.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(12)

                Button(action: {
                    viewModel.submitCancellation()
                }) {
                    Text("Отменить заказ")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ZStack{
                    Text("Укажите причину отмены")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationButtonToPreviousScreenView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .overlay(
            // Уведомление
            VStack {
                if viewModel.showNotification {
                    Text("Заказ успешно отменён")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: viewModel.showNotification)
                }
            },
            alignment: .bottom
        )
    }
    
}

struct ButtonReasonView: View{
    @Binding var reason: CancellationReasonModel
    @StateObject var viewModel: CancellationViewModel
    
    var body: some View {
        Button(action: {
            viewModel.selectReason(reason)
        }) {
            Image(reason.isSelected ? "checkBoxTrue" : "checkBoxFalse")
                .padding(.leading, 28)
            Text(reason.title)
                .foregroundColor(Color.black)
                .font(.system(size: 16))
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Spacer()
                .frame(width: 35, height: 10)
                .padding(.leading, 0)
        }
    }
}

struct NavigationButtonToPreviousScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image("redBack")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

