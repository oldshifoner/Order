//
//  SendReviewViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import UIKit

class SendReviewViewCell: UITableViewCell{
    
    public var clouserCheckBoxAnonymously: ((Bool) -> Void)?
    
    public var viewModel: TableViewModel.ViewModelType.Review?{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        guard let viewModel else {return}
        checkBoxAnonymously.isChecked = viewModel.anonymously
    }
    
    override func prepareForReuse() {
        checkBoxAnonymously.isChecked = false
    }
    private lazy var checkBoxAnonymously: CheckBoxAnonymouslyUIButton = {
        let checkBox = CheckBoxAnonymouslyUIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        checkBox.backgroundColor = .clear
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.clipsToBounds = true
        checkBox.clouser = {[weak self] value in
            self?.clouserCheckBoxAnonymously?(value)
        }
        return checkBox
    }()
    private lazy var anonimLabel: UILabel = {
        let label = UILabel()
        label.text = "Оставить отзыв анонимно"
        label.textColor = .black
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "System", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 1.0)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(sendButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    @objc func sendButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(checkBoxAnonymously)
        contentView.addSubview(anonimLabel)
        contentView.addSubview(sendButton)
        checkBoxAnonymously.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkBoxAnonymously.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkBoxAnonymously.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        checkBoxAnonymously.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        contentView.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 20).isActive = true
        
        anonimLabel.leftAnchor.constraint(equalTo: checkBoxAnonymously.rightAnchor, constant: 8).isActive = true
        anonimLabel.centerYAnchor.constraint(equalTo: checkBoxAnonymously.centerYAnchor).isActive = true
        
        sendButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        sendButton.topAnchor.constraint(equalTo: checkBoxAnonymously.bottomAnchor, constant: 20).isActive = true
        sendButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        sendButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
}
