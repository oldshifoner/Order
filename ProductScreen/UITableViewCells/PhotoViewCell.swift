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
    public var deleteImageClouser: (() -> Void)?
    
    private lazy var selfImageUIView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var closeButtonView: UIButton = {
        let button = UIButton()
        let imageView = UIImageView(image: UIImage(named: "delete"))
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchDown)
        return button
    }()
    @objc func buttonTapped(_ sender: UIButton) {
        deleteImageClouser?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
        contentView.addSubview(selfImageUIView)
        contentView.addSubview(closeButtonView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selfImageUIView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            selfImageUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selfImageUIView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            selfImageUIView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
        NSLayoutConstraint.activate([
            closeButtonView.heightAnchor.constraint(equalToConstant: 20),
            closeButtonView.widthAnchor.constraint(equalToConstant: 20),
            closeButtonView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -4),
            closeButtonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        ])
    }
   

}
