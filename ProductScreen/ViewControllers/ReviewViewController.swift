//
//  ReviewViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 31.10.2024.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private lazy var viewModel = ReviewViewModel()
    private var activeTextField: UITextField?
    
    init(reviewViewModel: TableViewModel.ViewModelType.Review) {
        super.init(nibName: nil, bundle: nil)
        viewModel.review = reviewViewModel
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let activeTextField = activeTextField else { return }
            
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let keyboardHeight = keyboardFrame.height
                let textFieldBottomY = activeTextField.convert(activeTextField.bounds, to: view).maxY
                let screenHeight = view.bounds.height
                
                if textFieldBottomY > (screenHeight - keyboardHeight) {
                    view.frame.origin.y = -(textFieldBottomY - (screenHeight - keyboardHeight) + 20)
                }
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            view.frame.origin.y = 0
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            tableView.separatorStyle = .none
            tableView.register(TitleReviewCell.self, forCellReuseIdentifier: String(describing: TitleReviewCell.self))
            tableView.register(PlusMinusCommentViewCell.self, forCellReuseIdentifier: String(describing: PlusMinusCommentViewCell.self))
            tableView.register(EvaluationViewCell.self, forCellReuseIdentifier: String(describing: EvaluationViewCell.self))
            tableView.register(SendReviewViewCell.self, forCellReuseIdentifier: String(describing: SendReviewViewCell.self))
            return tableView
        }()
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
        viewModel.evaluationUpdate = { [weak self] index in
            guard let self else { return }
            tableView.beginUpdates()
            tableView.reloadRows(at: [.init(row: index, section: 0)], with: .none)
            tableView.endUpdates()
            return
        }
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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
}
extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
            
        case .titleReview(let titleReview):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleReviewCell.self)) as? TitleReviewCell else {
                return UITableViewCell()
            }
            cell.viewModel = titleReview
            cell.selectionStyle = .none
            return cell
        case .plusMinusComment(let plusMinusComment):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlusMinusCommentViewCell.self)) as? PlusMinusCommentViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = plusMinusComment
            cell.clouserActiveTextField = { [weak self] textField in
                guard let self else { return }
                self.activeTextField = textField
            }
            cell.selectionStyle = .none
            return cell
        case .evaluation(let evaluation):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EvaluationViewCell.self)) as? EvaluationViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = evaluation
            cell.imageTapped = { [weak self] index in
                guard let self else { return }
                guard let clouser = self.viewModel.clouser else { return }
                clouser(index)
            }
            cell.selectionStyle = .none
            return cell
        case .sendReview(let sendReview):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SendReviewViewCell.self)) as? SendReviewViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = sendReview
            cell.clouserCheckBoxAnonymously = { [weak self] value in
                guard let self else { return }
                guard let clouser = self.viewModel.changeAnonymouslyClouser else { return }
                clouser(value)
            }
            cell.selectionStyle = .none
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

