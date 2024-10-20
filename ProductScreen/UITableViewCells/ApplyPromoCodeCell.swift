//
//  ApplayPromoCodeCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 22.10.2024.
//

import UIKit

class ApplyPromoCodeCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.ApplyPromo? {
        didSet {
            
        }
    }
    
    var nextViewController: (() -> ())?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "promocode"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var applyLabel: UILabel = {
       let label = UILabel()
        label.text = "Применить промокод"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        label.backgroundColor = .clear
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 0.1)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(applyButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    @objc func applyButtonTapped(_ sender: UIButton) {
        nextViewController?()
    }
    
    private func setupUI(){
        contentView.backgroundColor = .white
        contentView.addSubview(button)
        button.addSubview(applyLabel)
        button.addSubview(iconView)
        
        NSLayoutConstraint.activate([
        applyLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
        applyLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        applyLabel.heightAnchor.constraint(equalToConstant: 22),])
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 24)])
        iconView.rightAnchor.constraint(equalTo: applyLabel.leftAnchor, constant: -10).isActive = true
        
        NSLayoutConstraint.activate([
        button.heightAnchor.constraint(equalToConstant: 54),
        button.widthAnchor.constraint(equalToConstant: 343)])
        
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
}
