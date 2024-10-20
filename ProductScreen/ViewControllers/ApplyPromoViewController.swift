//
//  ApplyPromoViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 26.10.2024.
//

import UIKit

class ApplyPromoViewController: UIViewController{
    
    private lazy var applyPromoViewModel = ApplyPromoViewModel()
    
    init(secretPromo: [TableViewModel], closure: @escaping (String) -> Void) {
        super.init(nibName: nil, bundle: nil)
        applyPromoViewModel.closure = closure
        applyPromoViewModel.secretPromocodes = secretPromo
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
        label.text = "Применить промокод"
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
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            tableView.register(EnterPromoCell.self, forCellReuseIdentifier: String(describing: EnterPromoCell.self))
            return tableView
        }()
    
    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            applyPromoViewModel.initArray()
            applyPromoViewModel.dataUpdated = { [weak self] in
                guard let self else { return }
                    tableView.reloadData()
                }
            applyPromoViewModel.nextViewController = { [weak self] in
                guard let self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            setupUI()
       }
    
    private func setupUI(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        view.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
       
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),

        ])
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
    }
    
}

extension ApplyPromoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        applyPromoViewModel.cellViewModels.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let applyPromoViewModel = self.applyPromoViewModel.cellViewModels[indexPath.row]
        
        switch applyPromoViewModel.type {
            
        case .enterSecretPromo(let enterSecretPromo):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EnterPromoCell.self)) as? EnterPromoCell else {
                return UITableViewCell()
            }
            cell.viewModel = enterSecretPromo
            cell.applyPromo = { [weak self] string in
                guard let self else { return }
                self.applyPromoViewModel.applyPromo(promoString: string)
            }
            cell.reloadData = { [weak self] in
                guard let self else { return }
                self.applyPromoViewModel.applyPromo(promoString: "")
            }
            cell.selectionStyle = .none
            return cell
            
        default: return UITableViewCell()
        }
    }
}
