//
//  TotalCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 22.10.2024.
//

import UIKit

class TotalCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Total? {
        didSet {
            updateUI()
        }
    }
    private func updateUI(){
        guard let viewModel else {
            return
        }
        priceLabelView.text = "Цена за 2 товара"
        priceValueView.text = viewModel.currentPrice
        discountValueView.text = viewModel.discount
        promocodesValueView.text = viewModel.promocodes
        paymentMethodValueView.text = viewModel.paymentMethod
        totalValueView.text = viewModel.totalPrice
        self.hidePromoButton.alpha = 1.0
        self.applyOrderButton.alpha = 1.0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        priceLabelView.text = nil
        priceValueView.text = nil
        discountValueView.text = nil
        promocodesValueView.text = nil
        paymentMethodValueView.text = nil
        totalValueView.text = nil
        hidePromoButton.isSelected = false
        self.hidePromoButton.alpha = 1.0
        self.applyOrderButton.alpha = 1.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    private lazy var hidePromoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Скрыть промокоды", for: .normal)
        button.setTitleColor(UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside, .touchUpOutside])
        return button
   }()
   
   @objc func buttonTapped(_ sender: UIButton) {
       UIView.animate(withDuration: 0, animations: {
           self.hidePromoButton.alpha = 0.25
       })
   }

   @objc func buttonReleased(_ sender: UIButton) {
       UIView.animate(withDuration: 0.3, animations: {
           self.hidePromoButton.alpha = 1.0
       })
   }
    private lazy var totalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        return view
    }()
    
    private lazy var priceLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var priceValueView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var discountLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.text = "Скидки"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var discountValueView: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var promocodesLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.text = "Промокоды"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var promocodesValueView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0/255, green: 183/255, blue: 117/255, alpha: 1)
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var paymentMethodLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.text = "Способ оплаты"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var paymentMethodValueView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var totalLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.text = "Итого"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var totalValueView: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var applyOrderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 70/255, blue: 17/255, alpha: 1)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonApplyOrderTapped(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonApplyOrderReleased(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonApplyOrderReleased(_:)), for: .touchUpOutside)
        return button
   }()
   
   @objc func buttonApplyOrderTapped(_ sender: UIButton) {
       UIView.performWithoutAnimation{
           self.applyOrderButton.alpha = 0.25
       }
   }

   @objc func buttonApplyOrderReleased(_ sender: UIButton) {
       UIView.animate(withDuration: 0.5, animations: {
           self.applyOrderButton.alpha = 1.0
       })
   }
    
    private lazy var applyOrderLabel: UILabel = {
       let label = UILabel()
        label.text = "Оформить заказ"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = .clear
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var termsOfferLabel: UILabel = {
        let label = UILabel()
        
        let onePartText = NSAttributedString(string: "Нажимая кнопку «Оформить заказ», Вы соглашаетесь с ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)])
        let twoPartText = NSAttributedString(string: "Условиями оферты", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)])
        let fullText = NSMutableAttributedString()
        fullText.append(onePartText)
        fullText.append(twoPartText)
        
        label.attributedText = fullText
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.isEnabled = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var iconInfoButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView(image: UIImage(named: "infoIcon"))
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        return view
    }()
     
    
    private func setupUI(){
        contentView.addSubview(hidePromoButton)
        contentView.addSubview(totalView)
        contentView.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: 0).isActive = true
        
        totalView.addSubview(iconInfoButton)
        totalView.addSubview(lineView)
        totalView.addSubview(applyOrderButton)
        
        applyOrderButton.addSubview(applyOrderLabel)
        
        totalView.addSubview(priceLabelView)
        totalView.addSubview(discountLabelView)
        totalView.addSubview(promocodesLabelView)
        totalView.addSubview(paymentMethodLabelView)
        totalView.addSubview(totalLabelView)
        totalView.addSubview(termsOfferLabel)
        
        totalView.addSubview(priceValueView)
        totalView.addSubview(discountValueView)
        totalView.addSubview(promocodesValueView)
        totalView.addSubview(paymentMethodValueView)
        totalView.addSubview(totalValueView)
        
        
//Установка якорей для name
        priceLabelView.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 24).isActive = true
        priceLabelView.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        
        discountLabelView.topAnchor.constraint(equalTo: priceValueView.bottomAnchor, constant: 10).isActive = true
        discountLabelView.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        
        promocodesLabelView.topAnchor.constraint(equalTo: discountValueView.bottomAnchor, constant: 10).isActive = true
        promocodesLabelView.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        
        paymentMethodLabelView.topAnchor.constraint(equalTo: promocodesValueView.bottomAnchor, constant: 10).isActive = true
        paymentMethodLabelView.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        
        totalLabelView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16).isActive = true
        totalLabelView.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        
        
//Установка якорей для value
      
        priceValueView.topAnchor.constraint(equalTo: priceLabelView.topAnchor, constant: 0).isActive = true
        priceValueView.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
        priceValueView.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        
        discountValueView.topAnchor.constraint(equalTo: discountLabelView.topAnchor, constant: 0).isActive = true
        discountValueView.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
        discountValueView.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
       
        promocodesValueView.topAnchor.constraint(equalTo: promocodesLabelView.topAnchor, constant: 0).isActive = true
        promocodesValueView.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
        promocodesValueView.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        
        paymentMethodValueView.topAnchor.constraint(equalTo: paymentMethodLabelView.topAnchor, constant: 0).isActive = true
        paymentMethodValueView.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
        paymentMethodValueView.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
      
        totalValueView.topAnchor.constraint(equalTo: totalLabelView.topAnchor, constant: 0).isActive = true
        totalValueView.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
        totalValueView.widthAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        
//lineView
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        lineView.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
        lineView.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        lineView.topAnchor.constraint(equalTo: paymentMethodLabelView.bottomAnchor, constant: 16).isActive = true
        
//iconInfoButton
        NSLayoutConstraint.activate([
            iconInfoButton.centerYAnchor.constraint(equalTo: promocodesLabelView.centerYAnchor),
            iconInfoButton.heightAnchor.constraint(equalToConstant: 20),
            iconInfoButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        iconInfoButton.leftAnchor.constraint(equalTo: promocodesLabelView.rightAnchor, constant: 4).isActive = true

//applayOrderButton
        NSLayoutConstraint.activate([
        applyOrderButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        applyOrderButton.topAnchor.constraint(equalTo: totalValueView.bottomAnchor, constant: 16).isActive = true
        applyOrderButton.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 32).isActive = true
        applyOrderButton.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -32).isActive = true
    
//applayOrderLabel
        NSLayoutConstraint.activate([
        applyOrderLabel.centerYAnchor.constraint(equalTo: applyOrderButton.centerYAnchor),
        applyOrderLabel.centerXAnchor.constraint(equalTo: applyOrderButton.centerXAnchor),
        ])
        
//termsOfferLabel
        termsOfferLabel.topAnchor.constraint(equalTo: applyOrderButton.bottomAnchor, constant: 16).isActive = true
        termsOfferLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 78).isActive = true
        termsOfferLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -78).isActive = true
    
//totalView
        totalView.topAnchor.constraint(equalTo: hidePromoButton.bottomAnchor, constant: 24).isActive = true
        totalView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        totalView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        totalView.bottomAnchor.constraint(equalTo: termsOfferLabel.bottomAnchor, constant: 40).isActive = true
    
        NSLayoutConstraint.activate([
        hidePromoButton.heightAnchor.constraint(equalToConstant: 40),
        hidePromoButton.widthAnchor.constraint(equalToConstant: 176)])
        
        hidePromoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        hidePromoButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        
    }
}
