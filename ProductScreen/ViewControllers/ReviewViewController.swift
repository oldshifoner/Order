//
//  ReviewViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 31.10.2024.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private lazy var viewModel = ReviewViewModel()
    
    init(reviewViewModel: TableViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel.review = reviewViewModel
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = reviewList.screenTitle
        return label
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView(image: UIImage(named: "redBack"))
        button.setImage(imageView.image, for: .normal)
        button.backgroundColor = .clear
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showReview()
        setupUI()
    }
    
    private func setupUI(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .clear
        view.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.titleView = titleLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
