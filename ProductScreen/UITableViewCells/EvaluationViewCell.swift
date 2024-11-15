//
//  EvaluationViewCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 04.11.2024.
//

import UIKit

class EvaluationViewCell: UITableViewCell{
    
    public var imageTapped: ((Int)->Void)?
    
    public var viewModel: TableViewModel.ViewModelType.Review? {
        didSet {
            updateUI()
            assignmentOfClouserForStarImages()
        }
    }
    private func updateUI() {
        guard let viewModel else { return }
        updateEvaluationUI(viewModel: viewModel)
    }
    
    private func updateEvaluationUI(viewModel: TableViewModel.ViewModelType.Review){
        
        for index in 0..<starImages.count {
            starImages[index].image = UIImage(named: "starGray")
        }
        evaluationLabel.text = "Ваша оценка"
        evaluationLabel.textColor = UIColor(_colorLiteralRed: 122/255, green: 122/255, blue: 122/255, alpha: 1.0)
        
        guard let evaluation = viewModel.evaluation else{ return }
        let count = evaluation.index
        let name = evaluation.name
       
        for index in 0..<count {
            starImages[index].image = UIImage(named: "starGold")
        }
        
        evaluationLabel.text = name
        evaluationLabel.textColor = .black
        setupErrorUI(height: 0, bottomAnchor: 0)
    }
    
    private func assignmentOfClouserForStarImages(){
        for index in 0..<starImages.count{
            starImages[index].imageIsTapped = { [weak self] in
                self?.imageTapped?(index)
            }
        }
    }
    
    override func prepareForReuse() {
        for index in 0..<starImages.count {
            starImages[index].image = nil
        }
        evaluationLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var starImages: [StarUIImageView] = [
        StarUIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)),
        StarUIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)),
        StarUIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)),
        StarUIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)),
        StarUIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private lazy var backgroundEvaluationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    private lazy var evaluationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "System", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var backgroundErrorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 236/255, blue: 236/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Для продолжения поставьте оценку товару"
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var errorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "error")
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private func setupUI() {
        contentView.addSubview(backgroundEvaluationView)
        backgroundEvaluationView.addSubview(evaluationLabel)
        backgroundEvaluationView.addSubview(starImages[0])
        backgroundEvaluationView.addSubview(starImages[1])
        backgroundEvaluationView.addSubview(starImages[2])
        backgroundEvaluationView.addSubview(starImages[3])
        backgroundEvaluationView.addSubview(starImages[4])
        contentView.addSubview(backgroundErrorView)
        backgroundErrorView.addSubview(errorLabel)
        backgroundErrorView.addSubview(errorImage)
        contentView.bottomAnchor.constraint(equalTo: backgroundErrorView.bottomAnchor).isActive = true
        
        setupErrorUI(height: 65, bottomAnchor: 12)
        
        NSLayoutConstraint.activate([
            backgroundEvaluationView.heightAnchor.constraint(equalToConstant: 54),
            backgroundEvaluationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            backgroundEvaluationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            backgroundEvaluationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            evaluationLabel.centerYAnchor.constraint(equalTo: backgroundEvaluationView.centerYAnchor),
            evaluationLabel.leftAnchor.constraint(equalTo: backgroundEvaluationView.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            starImages[4].heightAnchor.constraint(equalToConstant: 18),
            starImages[4].widthAnchor.constraint(equalToConstant: 18),
            starImages[4].centerYAnchor.constraint(equalTo: backgroundEvaluationView.centerYAnchor),
            starImages[4].rightAnchor.constraint(equalTo: backgroundEvaluationView.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            starImages[3].heightAnchor.constraint(equalToConstant: 18),
            starImages[3].widthAnchor.constraint(equalToConstant: 18),
            starImages[3].centerYAnchor.constraint(equalTo: backgroundEvaluationView.centerYAnchor),
            starImages[3].rightAnchor.constraint(equalTo: starImages[4].leftAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            starImages[2].heightAnchor.constraint(equalToConstant: 18),
            starImages[2].widthAnchor.constraint(equalToConstant: 18),
            starImages[2].centerYAnchor.constraint(equalTo: backgroundEvaluationView.centerYAnchor),
            starImages[2].rightAnchor.constraint(equalTo: starImages[3].leftAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            starImages[1].heightAnchor.constraint(equalToConstant: 18),
            starImages[1].widthAnchor.constraint(equalToConstant: 18),
            starImages[1].centerYAnchor.constraint(equalTo: backgroundEvaluationView.centerYAnchor),
            starImages[1].rightAnchor.constraint(equalTo: starImages[2].leftAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            starImages[0].heightAnchor.constraint(equalToConstant: 18),
            starImages[0].widthAnchor.constraint(equalToConstant: 18),
            starImages[0].centerYAnchor.constraint(equalTo: backgroundEvaluationView.centerYAnchor),
            starImages[0].rightAnchor.constraint(equalTo: starImages[1].leftAnchor, constant: -10),
        ])
        
    }
    
    private func setupErrorUI(height: Int, bottomAnchor: Int){
        NSLayoutConstraint.activate([
            backgroundErrorView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            backgroundErrorView.topAnchor.constraint(equalTo: backgroundEvaluationView.bottomAnchor, constant: CGFloat(bottomAnchor)),
            backgroundErrorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            backgroundErrorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 280),
            errorLabel.centerYAnchor.constraint(equalTo: backgroundErrorView.centerYAnchor),
            errorLabel.leftAnchor.constraint(equalTo: backgroundErrorView.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            errorImage.heightAnchor.constraint(equalToConstant: 20),
            errorImage.widthAnchor.constraint(equalToConstant: 20),
            errorImage.topAnchor.constraint(equalTo: backgroundErrorView.topAnchor, constant: 14),
            errorImage.rightAnchor.constraint(equalTo: backgroundErrorView.rightAnchor, constant: -18),
        ])
    }
    
    
    
}
