//
//  PlusMinusCommentViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import UIKit

class PlusMinusCommentViewCell: UITableViewCell, UITextFieldDelegate{
    
    public var clouserActiveTextField: ((UITextField) -> ())?
    
    var viewModel: TableViewModel.ViewModelType.Review? {
        didSet {
            updateUI()
        }
    }
    private func updateUI() {
        guard let _viewModel = viewModel else {
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
    
    private var activeTextField: UITextField?
    
    private lazy var advantagesTextField: UITextField = {
        let textField = ReviewUITextField()
        textField.delegate = self
        return textField
    }()
    private lazy var disadvantagesTextField: UITextField = {
        let textField = ReviewUITextField()
        textField.delegate = self
        return textField
    }()
    private lazy var commentTextField: UITextField = {
        let textField = ReviewUITextField()
        textField.delegate = self
        return textField
    }()
    func textFieldDidBeginEditing(_ textField: UITextField) {
            activeTextField = textField
            addNextButton(to: textField)
            guard let activeTextField else {return}
            clouserActiveTextField?(activeTextField)
        }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
        textField.rightView = nil
        guard let activeTextField else {return}
        clouserActiveTextField?(activeTextField)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goToNextTextField(currentTextField: textField)
        return true
    }
    
    private func addNextButton(to textField: UITextField) {
        let nextButton = UIButton(type: .system)
        let rightContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: textField.frame.height))
        nextButton.setTitle("Далее", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.frame = CGRect(x: 0, y: 0, width: 50, height: textField.frame.height)
        rightContainerView.addSubview(nextButton)
        textField.rightView = rightContainerView
        textField.rightViewMode = .always
    }
    
    @objc private func nextButtonTapped() {
        guard let activeTextField = activeTextField else { return }
        goToNextTextField(currentTextField: activeTextField)
    }

    private func goToNextTextField(currentTextField: UITextField) {
        if currentTextField == advantagesTextField {
            disadvantagesTextField.becomeFirstResponder()
        } else if currentTextField == disadvantagesTextField {
            commentTextField.becomeFirstResponder()
        } else {
            currentTextField.resignFirstResponder()
        }
    }
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
            advantagesTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
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

