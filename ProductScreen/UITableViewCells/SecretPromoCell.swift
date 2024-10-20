//
//  SecretPromoCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 26.10.2024.
//

import UIKit

class SecretPromoCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.SecretPromo? {
        didSet {
            updateUI()
        }
    }
    
    var toggleValueChanged: ((Bool,String) -> ())?
    
    private func updateUI() {
        guard let viewModel else { return }
        namePromoLabel.text = viewModel.title
        switchButton.isOn = viewModel.isActive
        percentLabel.text = viewModel.percent
        dateLabel.text = "По 2 марта"
        infoLabel.text = viewModel.info
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        guard let viewModel else {
            return
        }
        namePromoLabel.text = nil
        percentLabel.text = nil
        dateLabel.text = nil
        infoLabel.text = nil
        switchButton.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    lazy var switchButton: UISwitch = {
        let button = UISwitch()
        button.onTintColor = UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.cornerRadius = 12
        mainView.clipsToBounds = true
        return mainView
    }()
    
    private lazy var infoTitleView: UIView = {
        let infoTitleView = UIView()
        infoTitleView.translatesAutoresizingMaskIntoConstraints = false
        return infoTitleView
    }()
    
    private lazy var namePromoLabel: UILabel = {
        let namePromoLabel = UILabel()
        namePromoLabel.textColor = .black
        namePromoLabel.numberOfLines = 0
        namePromoLabel.backgroundColor = .clear
        namePromoLabel.textAlignment = NSTextAlignment.left
        namePromoLabel.font = UIFont(name: "System", size: 16)
        namePromoLabel.lineBreakMode = .byCharWrapping
        namePromoLabel.translatesAutoresizingMaskIntoConstraints = false
        return namePromoLabel
    }()
    
    private lazy var percentView: UIView = {
        let percentView = UIView()
        percentView.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 117/255, alpha: 1)
        percentView.translatesAutoresizingMaskIntoConstraints = false
        percentView.layer.cornerRadius = 10
        percentView.clipsToBounds = true
        return percentView
    }()
    
    private lazy var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.textColor = .white
        percentLabel.numberOfLines = 1
        percentLabel.backgroundColor = .clear
        percentLabel.textAlignment = NSTextAlignment.center
        percentLabel.font = UIFont.systemFont(ofSize: 12)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        return percentLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        dateLabel.numberOfLines = 1
        dateLabel.backgroundColor = .clear
        dateLabel.textAlignment = NSTextAlignment.left
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        infoLabel.numberOfLines = 0
        infoLabel.backgroundColor = .clear
        infoLabel.textAlignment = NSTextAlignment.left
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
    private lazy var iconInfoButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView(image: UIImage(named: "infoIcon"))
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside, .touchUpOutside])
        return button
    }()
    
    @objc func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            self.iconInfoButton.alpha = 0.5
        })
    }

    @objc func buttonReleased(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            self.iconInfoButton.alpha = 1.0
        })
    }
    
    private lazy var circleViewLeft: UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .white
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = 8
        circleView.layer.masksToBounds = true
        return circleView
    }()
    private lazy var circleViewRight: UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .white
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = 8
        circleView.layer.masksToBounds = true
        return circleView
    }()
    
    func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(mainView)
        mainView.addSubview(switchButton)
        mainView.addSubview(infoTitleView)
        infoTitleView.addSubview(namePromoLabel)
        infoTitleView.addSubview(percentView)
        percentView.addSubview(percentLabel)
        infoTitleView.addSubview(iconInfoButton)
        infoTitleView.addSubview(dateLabel)
        mainView.addSubview(infoLabel)
        mainView.addSubview(circleViewLeft)
        mainView.addSubview(circleViewRight)
        
        contentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 16).isActive = true
        
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        mainView.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8).isActive = true
        
        NSLayoutConstraint.activate([
        switchButton.heightAnchor.constraint(equalToConstant: 24),
        switchButton.widthAnchor.constraint(equalToConstant: 42),
        switchButton.centerYAnchor.constraint(equalTo: infoTitleView.centerYAnchor, constant: -2)
        ])
        switchButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
        
        infoTitleView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12).isActive = true
        infoTitleView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        infoTitleView.rightAnchor.constraint(equalTo: switchButton.leftAnchor, constant: 0).isActive = true
        infoTitleView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0).isActive = true
        
        namePromoLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        namePromoLabel.topAnchor.constraint(equalTo: infoTitleView.topAnchor, constant: 0).isActive = true
        namePromoLabel.leftAnchor.constraint(equalTo: infoTitleView.leftAnchor, constant: 0).isActive = true
        
        NSLayoutConstraint.activate([
        percentView.heightAnchor.constraint(equalToConstant: 20),
        percentView.centerYAnchor.constraint(equalTo: namePromoLabel.centerYAnchor),
        ])
        percentView.leftAnchor.constraint(equalTo: namePromoLabel.rightAnchor, constant: 10).isActive = true
        
        NSLayoutConstraint.activate([
        percentView.centerYAnchor.constraint(equalTo: percentView.centerYAnchor),
        percentView.centerXAnchor.constraint(equalTo: percentView.centerXAnchor)
        ])
        percentLabel.topAnchor.constraint(equalTo: percentView.topAnchor, constant: 2).isActive = true
        percentLabel.leftAnchor.constraint(equalTo: percentView.leftAnchor, constant: 6).isActive = true
        percentLabel.rightAnchor.constraint(equalTo: percentView.rightAnchor, constant: -6).isActive = true
        percentLabel.bottomAnchor.constraint(equalTo: percentView.bottomAnchor, constant: -2).isActive = true
        
        NSLayoutConstraint.activate([
        iconInfoButton.centerYAnchor.constraint(equalTo: percentView.centerYAnchor),
        iconInfoButton.heightAnchor.constraint(equalToConstant: 20),
        iconInfoButton.widthAnchor.constraint(equalToConstant: 20),
        ])
        iconInfoButton.leftAnchor.constraint(equalTo: percentView.rightAnchor, constant: 4).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: namePromoLabel.bottomAnchor, constant: 0).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: infoTitleView.leftAnchor, constant: 0).isActive = true
    
        infoLabel.topAnchor.constraint(equalTo: infoTitleView.bottomAnchor, constant: 8).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
    
        NSLayoutConstraint.activate([
        circleViewLeft.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        circleViewLeft.heightAnchor.constraint(equalToConstant: 16),
        circleViewLeft.widthAnchor.constraint(equalToConstant: 16),
        ])
        circleViewLeft.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: -8).isActive = true
      
        NSLayoutConstraint.activate([
        circleViewRight.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        circleViewRight.heightAnchor.constraint(equalToConstant: 16),
        circleViewRight.widthAnchor.constraint(equalToConstant: 16),
        ])
        circleViewRight.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 8).isActive = true
    }
    
}
