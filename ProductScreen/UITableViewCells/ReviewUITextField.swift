//
//  ReviewUITextField.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import UIKit

class ReviewUITextField: UITextField {

    override init(frame: CGRect) {
            super.init(frame: frame)
            setupProperties()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupProperties()
        }

    private func setupProperties() {
        super.textColor = .black
        super.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(_colorLiteralRed: 122/255, green: 122/255, blue: 122/255, alpha: 1.0)])
        super.backgroundColor = UIColor(_colorLiteralRed: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        super.textAlignment = NSTextAlignment.left
        super.font = UIFont.systemFont(ofSize: 16)
        super.translatesAutoresizingMaskIntoConstraints = false
        super.layer.cornerRadius = 12
        super.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: super.frame.height))
        super.leftViewMode = .always
        super.tintColor = .red
    }
}

