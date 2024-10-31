//
//  ListReviewsViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 31.10.2024.
//

import UIKit

struct MyReviewsList {

    struct Review {
        let title: String
        let size: String
        let evaluation: String? = nil
        let titleImage: String
        let selfImages: [String]? = nil
        let advantages: String? = nil
        let disadvantages: String? = nil
        let comment: String? = nil
        let anonymously: Bool
        let isWritten: Bool
    }
    var screenTitle: String
    var reviews: [MyReviewsList.Review]
}

let reviewList = MyReviewsList(screenTitle: "Напишите отзыв", reviews: [
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "17", titleImage: "goldRingProduct1", anonymously: true, isWritten: false),
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "15", titleImage: "goldRingProduct2", anonymously: true, isWritten: false),
    .init(title: "Серебрянное плоское обручальное кольцо 6 мм", size: "12", titleImage: "silverRingProduct1", anonymously: true, isWritten: false),
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "20", titleImage: "goldRingProduct3", anonymously: true, isWritten: false),
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "20", titleImage: "goldRingProduct4", anonymously: true, isWritten: true)])


class ListReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var viewModel = ReviewsListViewModel()
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            tableView.separatorStyle = .none
            tableView.register(ReviewCell.self, forCellReuseIdentifier: String(describing: ReviewCell.self))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showReviews(reviewList: reviewList)
        setupUI()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(indexPath)
        self.navigationController?.pushViewController(ReviewViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
            
        case .review(let review):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewCell.self)) as? ReviewCell else {
                return UITableViewCell()
            }
            cell.viewModel = review
            cell.selectionStyle = .gray
            cell.backgroundColor = .white
            return cell
            
        default: return UITableViewCell()
        }
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
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
}
