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
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "17", titleImage: "goldRingPruduct1", anonymously: true, isWritten: false),
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "15", titleImage: "goldRingPruduct2", anonymously: true, isWritten: false),
    .init(title: "Серебрянное плоское обручальное кольцо 6 мм", size: "12", titleImage: "silverRingProduct1", anonymously: true, isWritten: false),
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "20", titleImage: "goldRingPruduct3", anonymously: true, isWritten: false),
    .init(title: "Золотое плоское обручальное кольцо 4 мм", size: "20", titleImage: "goldRingPruduct4", anonymously: true, isWritten: true)])


class ListReviewsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
