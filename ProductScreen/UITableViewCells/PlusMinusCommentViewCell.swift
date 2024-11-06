//
//  PlusMinusCommentViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import UIKit

class PlusMinusCommentViewCell: UITableViewCell{
    var viewModel: TableViewModel.ViewModelType.Review? {
        didSet {
            updateUI()
        }
    }
    private func updateUI() {
        guard let viewModel else {
            return
        }
        advantagesTextField.placeholder = "Достоинства"
        disadvantagesTextField.placeholder = "Недостатки"
        commentTextField.placeholder = "Комментарий"
    }
    
    override func prepareForReuse() {
        advantagesTextField.placeholder = nil
        disadvantagesTextField.placeholder = nil
        commentTextField.placeholder = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var advantagesTextField: UITextField = {
        let textField = ReviewUITextField()
        return textField
    }()
    private lazy var disadvantagesTextField: UITextField = {
        let textField = ReviewUITextField()
        return textField
    }()
    private lazy var commentTextField: UITextField = {
        let textField = ReviewUITextField()
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(advantagesTextField)
        contentView.addSubview(disadvantagesTextField)
        contentView.addSubview(commentTextField)
        contentView.bottomAnchor.constraint(equalTo: commentTextField.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            advantagesTextField.heightAnchor.constraint(equalToConstant: 54),
            advantagesTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            advantagesTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            advantagesTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            disadvantagesTextField.heightAnchor.constraint(equalToConstant: 54),
            disadvantagesTextField.topAnchor.constraint(equalTo: advantagesTextField.bottomAnchor, constant: 16),
            disadvantagesTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            disadvantagesTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            commentTextField.heightAnchor.constraint(equalToConstant: 54),
            commentTextField.topAnchor.constraint(equalTo: disadvantagesTextField.bottomAnchor, constant: 16),
            commentTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            commentTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
    
    }
    
    
    
}

