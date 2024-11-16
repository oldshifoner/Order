//
//  AddPhotoViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 17.11.2024.
//

import UIKit

class AddPhotoViewCell: UICollectionViewCell{
    
    public var addNextPhoto: (()->Void)?
    
    private lazy var cloudImageUIView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cloud")
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        setupUI()
    }
    
    private func setupUI(){
        contentView.addSubview(cloudImageUIView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        cloudImageUIView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        cloudImageUIView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        NSLayoutConstraint.activate([
            cloudImageUIView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 27),
            cloudImageUIView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 32),
        ])
    }
}

