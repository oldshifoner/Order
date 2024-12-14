//
//  MainViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 10.12.2024.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController{
    
    private let secretPromocodes: [TableViewModel] = []
    
    
    override func viewDidLoad() {
        //pushOrderRefusalContentView()
        setupUI()
    }
    
    @objc private func pushOrderRefusalContentView(){
        let orderRefusalContentView = OrderRefusalContentView()
        let hostingController = UIHostingController(rootView: orderRefusalContentView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    @objc private func pushApplyPromoViewController(){
        self.navigationController?.pushViewController(ApplyPromoViewController(secretPromo: secretPromocodes , closure: {_ in }), animated: true)
        
    }
    @objc private func pushListReviewsViewController(){
        self.navigationController?.pushViewController(ListReviewsViewController(), animated: true)
    }
    @objc private func pushViewController(){
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    
    
    
    private func setupUI(){
        view.backgroundColor = .white
        
        let enterPromocodeButton = createButton(withTitle: "Ввод промокода")
        let reviewButton = createButton(withTitle: "Отзыв")
        let orderCancellationButton = createButton(withTitle: "Отмена заказа")
        let order = createButton(withTitle: "Заказ")
        
        view.addSubview(enterPromocodeButton)
        view.addSubview(reviewButton)
        view.addSubview(orderCancellationButton)
        view.addSubview(order)
        
        enterPromocodeButton.addTarget(self, action: #selector(pushApplyPromoViewController), for: .touchDown)
        reviewButton.addTarget(self, action: #selector(pushListReviewsViewController), for: .touchDown)
        orderCancellationButton.addTarget(self, action: #selector(pushOrderRefusalContentView), for: .touchDown)
        order.addTarget(self, action: #selector(pushViewController), for: .touchDown)

        NSLayoutConstraint.activate([
            // Кнопка 1
            enterPromocodeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            enterPromocodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            enterPromocodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            enterPromocodeButton.heightAnchor.constraint(equalToConstant: 50),

            // Кнопка 2
            reviewButton.topAnchor.constraint(equalTo: enterPromocodeButton.bottomAnchor, constant: 20),
            reviewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reviewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reviewButton.heightAnchor.constraint(equalToConstant: 50),

            // Кнопка 3
            orderCancellationButton.topAnchor.constraint(equalTo: reviewButton.bottomAnchor, constant: 20),
            orderCancellationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orderCancellationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orderCancellationButton.heightAnchor.constraint(equalToConstant: 50),

            // Кнопка 4
            order.topAnchor.constraint(equalTo: orderCancellationButton.bottomAnchor, constant: 20),
            order.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            order.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            order.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
