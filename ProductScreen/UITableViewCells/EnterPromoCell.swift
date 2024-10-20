//
//  EnterPromoCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 27.10.2024.
//

import UIKit

class EnterPromoCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.EnterSecretPromo? {
        didSet {
            updateUI()
        }
    }
    
    var applyPromo: ((String) -> ())?
    var reloadData: (() -> ())?
    
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Введите промокод"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteTextFieldView: UIButton = {
        let button = UIButton()
        let imageView = UIImageView(image: UIImage(named: "close"))
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self, action: #selector(deleteTextFieldReleased(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func deleteTextFieldReleased(_ sender: UIButton) {
        textField.text = nil
        if (errorLabel.text != nil){
            reloadData?()
        }
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .red
        textField.backgroundColor = .clear
        textField.textAlignment = NSTextAlignment.left
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    @objc func textFieldDidChange(_ sender: UIButton) {
        textFieldView.layer.borderColor = UIColor.black.cgColor
        titleLabel.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        if (errorLabel.text != nil){
            reloadData?()
        }
        
    }
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 1)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(applyButtonTapped(_:)), for: .touchUpInside)
        return button
   }()
   
   @objc func applyButtonTapped(_ sender: UIButton) {
       applyPromo?(textField.text ?? "")
       textFieldView.layer.borderColor = UIColor.red.cgColor
       titleLabel.textColor = .red
   }
    private lazy var applyButtonLabel: UILabel = {
       let label = UILabel()
        label.text = "Применить"
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = .clear
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        errorLabel.text = viewModel.errorLabel
    }

    private func setupUI() {
        contentView.addSubview(textFieldView)
        textFieldView.addSubview(titleLabel)
        textFieldView.addSubview(deleteTextFieldView)
        textFieldView.addSubview(textField)
        contentView.addSubview(errorLabel)
        contentView.addSubview(applyButton)
        applyButton.addSubview(applyButtonLabel)
        
        contentView.bottomAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 30).isActive = true
        
        NSLayoutConstraint.activate([
            textFieldView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -8)])
        textFieldView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        textFieldView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        textFieldView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        NSLayoutConstraint.activate([
            deleteTextFieldView.heightAnchor.constraint(equalToConstant: 20),
            deleteTextFieldView.widthAnchor.constraint(equalToConstant: 20)])
        
        deleteTextFieldView.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor).isActive = true
        deleteTextFieldView.rightAnchor.constraint(equalTo: textFieldView.rightAnchor, constant: -12).isActive = true
        
       // NSLayoutConstraint.activate([
            //titleLabel.heightAnchor.constraint(equalToConstant: 54)])
        titleLabel.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: textFieldView.leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: textFieldView.rightAnchor, constant: -40).isActive = true
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 54)])
        textField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0).isActive = true
        textField.leftAnchor.constraint(equalTo: textFieldView.leftAnchor, constant: 12).isActive = true
        textField.rightAnchor.constraint(equalTo: textFieldView.rightAnchor, constant: -40).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 4).isActive = true
       // errorLabel.centerXAnchor.constraint(equalTo: textFieldView.centerXAnchor).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        NSLayoutConstraint.activate([
            applyButton.heightAnchor.constraint(equalToConstant: 54)])
        applyButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16).isActive = true
        applyButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        applyButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        applyButtonLabel.centerXAnchor.constraint(equalTo: applyButton.centerXAnchor).isActive = true
        applyButtonLabel.centerYAnchor.constraint(equalTo: applyButton.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
}
