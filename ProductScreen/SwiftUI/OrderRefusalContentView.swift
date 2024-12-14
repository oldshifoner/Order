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
                if viewModel.showError {
                    HStack{
                        Text("Пожалуйста, выберите причину")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14))
                            .background(Color.clear)
                            .padding(.top, 13)
                            .padding(.leading, 15)
                            .padding(.bottom, 16)
                            .padding(.trailing, 16)
                        Image("error")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .background(Color.clear)
                            .padding(.bottom, 14)
                            .padding(.trailing, 14)
                            .padding(.top, 14)
                      
                    }
                    .frame(height: 48)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 0)
                } 
                Spacer()
                    .frame(height: 16)

                ForEach(viewModel.reasons, id: \.self) { reason in
                    @State var reason = reason
                    ButtonReasonView(reason: $reason, viewModel: viewModel)
                }
                if viewModel.selectedOtherReason {
                    HStack{
                        TextField("Опишите проблему",text: .constant(""))
                            .font(.system(size: 16))
                            .background(Color.clear)
                            .accentColor(.black)
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                            .lineLimit(1)
                            .fixedSize()
                        Spacer()
                    }
                    .background(Color.init(red: 246/255, green: 246/255, blue: 246/255))
                    .cornerRadius(12)
                    .frame(height: 54)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 16)
                }
                HStack{
                    Text("Обычно деньги сразу возвращаются на карту. В некоторых случаях это может занять до 3 рабочих дней.")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .background(Color.clear)
                        .padding(.top, 12)
                        .padding(.leading, 16)
                        .padding(.bottom, 12)
                        .padding(.trailing, 16)
                    Spacer()
                    Image("yellowInfoIcon")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .background(Color.clear)
                        .padding(.bottom, 49)
                        .padding(.trailing, 16)
                        .padding(.top, 12)
                    
                }
                .frame(height: 85)
                .background(Color.init(red: 254/255, green: 247/255, blue: 222/255))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 0)
                .padding(.bottom, 0)

                Button(action: {
                    viewModel.submitCancellation()
                }) {
                    Text("Отменить заказ")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                }
                .background(Color.init(red: 255/255, green: 70/255, blue: 17/255))
                .cornerRadius(12)
                .frame(height: 54)
                .padding(.top, 6)
                .padding(.horizontal, 16)
                
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
            VStack {
                if viewModel.showNotification {
                    Text("Заказ успешно отменён")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.init(red: 34/255, green: 34/255, blue: 34/255).opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(32)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: viewModel.showNotification)
                        .padding(.horizontal, 84)
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
        
        .padding(.bottom, 15)
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

