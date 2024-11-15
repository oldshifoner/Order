//
//  UserPhotoViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 11.11.2024.
//

import UIKit

class PhotoViewCell: UICollectionViewCell{
    
}

class UserPhotoViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    enum Constants {
        static let padding: CGFloat = 10
        static let number: CGFloat = 4
    }
    private var tapGesture: UITapGestureRecognizer?
    private var clouser: ((Int) -> Void)?
    private let itemCount = 3
    private var width: Int?
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let selfImages = viewModel?.selfImages else {return 0}
        return itemCount
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        cell.contentView.backgroundColor = .red
        return cell
    }
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - Constants.padding * (Constants.number + 1)) / Constants.number
        return .init(width: width, height: width)
    }
    
    public var viewModel: TableViewModel.ViewModelType.Review? {
        didSet {
            updateUI()
            collectionView.reloadData()
        }
    }
   
    private var widthConstraion: NSLayoutConstraint?
    
    private func updateUI(){
        guard let viewModel else {return}
        guard let selfImages = viewModel.selfImages else{
            widthConstraion?.constant = 80
            collectionView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            setupFullButtonAddingPhotosUI()
            setTapGesture()
            return
        }
        removeTapGesture()
        widthConstraion?.constant = 100
        collectionView.backgroundColor = .clear
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let number: CGFloat = Constants.number
        let padding: CGFloat = Constants.padding
        
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = .init(top: 0, left: Constants.padding, bottom: 0, right: Constants.padding)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: "PhotoViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 12
        return collectionView
    }()
    private lazy var addingPhotosBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    @objc func handleCollectionViewTap() {
        print("collectionView tapped!")
        removeTapGesture()
        
        
        
        
    }
    private func setTapGesture(){
        guard let tapGesture else{
            self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCollectionViewTap))
            collectionView.addGestureRecognizer(self.tapGesture!)
            return
        }
    }
    private func removeTapGesture() {
        if let tapGesture = tapGesture {
            collectionView.removeGestureRecognizer(tapGesture)
            self.tapGesture = nil
        }
    }
    private lazy var cloudImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cloud")
        return image
    }()
    private lazy var addPhotosLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавьте фото или видео"
        label.textColor = .black
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addPhotosAddonLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите, чтобы выбрать файлы"
        label.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1.0)
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 12)
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
    private func setupUI(){
        contentView.addSubview(collectionView)
        setupUIWidthCollectionView()
    }
    
    private func setupFullButtonAddingPhotosUI(){
        collectionView.addSubview(cloudImage)
        collectionView.addSubview(addPhotosLabel)
        collectionView.addSubview(addPhotosAddonLabel)

        NSLayoutConstraint.activate([
            cloudImage.heightAnchor.constraint(equalToConstant: 16),
            cloudImage.widthAnchor.constraint(equalToConstant: 24),
            cloudImage.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            cloudImage.leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            addPhotosLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 21),
            addPhotosLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            addPhotosLabel.leftAnchor.constraint(equalTo: cloudImage.rightAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            addPhotosAddonLabel.topAnchor.constraint(equalTo: addPhotosLabel.bottomAnchor, constant: 2),
            addPhotosAddonLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            addPhotosAddonLabel.leftAnchor.constraint(equalTo: cloudImage.rightAnchor, constant: 16),
        ])
        
        
    }
    
    private func setupUIWidthCollectionView(){
        NSLayoutConstraint.activate([
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        ])
        
        widthConstraion = collectionView.heightAnchor.constraint(equalToConstant: 200)
        widthConstraion?.isActive = true
    }
}
