//
//  StarUIImageView.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 06.11.2024.
//

import UIKit

class StarUIImageView: UIImageView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProperties()
    }
    
    private func setupProperties() {
        super.backgroundColor = .clear
        super.translatesAutoresizingMaskIntoConstraints = false
    }
}
