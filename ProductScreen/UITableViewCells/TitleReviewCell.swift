//
//  TitleReviewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 03.11.2024.
//

import UIKit

class TitleReviewCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Review? {
        didSet {
            updateUI()
        }
    }
    private func updateUI() {
        guard let viewModel else {
            return
        }
        titleImage.image = UIImage(named: viewModel.titleImage)
        titleLabel.text = viewModel.title
        additionalLabel.text = "Размер: " + viewModel.size
    }
    
    override func prepareForReuse() {
        titleImage.image = nil
        titleLabel.text = nil
        additionalLabel.text = nil
    }
    
    private lazy var titleImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
   
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var additionalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1.0)
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(titleImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(additionalLabel)
        
        contentView.backgroundColor = .clear
        contentView.bottomAnchor.constraint(equalTo: titleImage.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalToConstant: 80),
            titleImage.widthAnchor.constraint(equalToConstant: 80),
            titleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50).isActive = true
        
        additionalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        additionalLabel.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 12).isActive = true
    
    }
    
}
