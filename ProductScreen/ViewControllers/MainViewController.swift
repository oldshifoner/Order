//
//  MainViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 10.12.2024.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController{
    
    override func viewDidLoad() {
        pushOrderRefusalContentView()
    }
    
    private func pushOrderRefusalContentView(){
        let orderRefusalContentView = OrderRefusalContentView()
        let hostingController = UIHostingController(rootView: orderRefusalContentView)
        navigationController?.pushViewController(hostingController, animated: true)
        
    }
}
