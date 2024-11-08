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
    
    private lazy var sendButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправить"
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = .clear
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   private lazy var publicationRulesLabel: UILabel = {
        let label = UILabel()
        let onePartText = NSAttributedString(string: "Перед отправкой отзыва, пожалуйста, ознакомьтесь с ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)])
        let twoPartText = NSAttributedString(string: "правилами публикации", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 1)])
        let fullText = NSMutableAttributedString()
        fullText.append(onePartText)
        fullText.append(twoPartText)
        
        label.attributedText = fullText
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.isEnabled = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        sendButton.addSubview(sendButtonLabel)
        contentView.addSubview(publicationRulesLabel)
        
        checkBoxAnonymously.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkBoxAnonymously.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkBoxAnonymously.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        checkBoxAnonymously.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        
        anonimLabel.leftAnchor.constraint(equalTo: checkBoxAnonymously.rightAnchor, constant: 8).isActive = true
        anonimLabel.centerYAnchor.constraint(equalTo: checkBoxAnonymously.centerYAnchor).isActive = true
        
        sendButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        sendButton.topAnchor.constraint(equalTo: checkBoxAnonymously.bottomAnchor, constant: 20).isActive = true
        sendButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        sendButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        sendButtonLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor).isActive = true
        sendButtonLabel.centerXAnchor.constraint(equalTo: sendButton.centerXAnchor).isActive = true
        
        publicationRulesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        publicationRulesLabel.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 12).isActive = true
        publicationRulesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 60).isActive = true
        publicationRulesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -60).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: publicationRulesLabel.bottomAnchor, constant: 16).isActive = true
    }
    
}
