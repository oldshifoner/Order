//
//  PhotoViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 15.11.2024.
//

import UIKit

class PhotoViewCell: UICollectionViewCell{
    public var selfImage: String? {
        didSet {
            guard let selfImage else {return}
            selfImageUIView.image = UIImage(named: selfImage)
        }
    }
    
    private lazy var selfImageUIView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
        contentView.addSubview(selfImageUIView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selfImageUIView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            selfImageUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selfImageUIView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            selfImageUIView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
   

}
