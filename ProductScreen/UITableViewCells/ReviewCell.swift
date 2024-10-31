//
//  ReviewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 31.10.2024.
//

import UIKit

class ReviewCell: UITableViewCell {
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
    }
    
    override func prepareForReuse() {
        titleImage.image = nil
        titleLabel.text = nil
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
        label.numberOfLines = 3
        label.backgroundColor = .clear
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrowRight")
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        contentView.addSubview(arrowImage)
        contentView.backgroundColor = .clear
        contentView.bottomAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 8).isActive = true
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalToConstant: 80),
            titleImage.widthAnchor.constraint(equalToConstant: 80),
            titleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 12).isActive = true
        
        NSLayoutConstraint.activate([
            arrowImage.heightAnchor.constraint(equalToConstant: 14),
            arrowImage.widthAnchor.constraint(equalToConstant: 8),
            arrowImage.centerYAnchor.constraint(equalTo: titleImage.centerYAnchor),
            arrowImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)])
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
