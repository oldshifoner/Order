//
//  ViewController.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 16.10.2024.
//

import UIKit

struct Order {

    struct Promocode {
        let title: String
        let percent: String
        let endDate: Date?
        let info: String?
        let active: Bool
        let applied: Bool? = false
    }

    struct Product {
        let price: Double
        let title: String
    }

    var screenTitle: String

    var promocodes: [Order.Promocode]
    
    var secretPromocodes: [Order.Promocode]

    let products: [Order.Product]

    let paymentDiscount: Double?

    let baseDiscount: Double?
}

let order = Order(screenTitle: "Промокоды",
    promocodes: [
        .init(title: "HELLO", percent: "-5%", endDate: Date() , info: "321312321442342352435235454352345r2345243523545235421345325Промокод действует на первый заказ в приложении", active: true),
        .init(title: "VESNA23", percent: "-23%", endDate: Date(), info: "Промокод действует для заказов от 30 000 ₽", active: false),
        .init(title: "543534423423455235543523525235235235235235325242523523525252352TheEnd", percent: "-100%", endDate: Date(), info: nil, active: false),
        .init(title: "4234234", percent: "-50%", endDate: Date(), info: nil, active: false),
        .init(title: "1343245", percent: "-50%", endDate: Date(), info: nil, active: false)], 
    secretPromocodes: [
        .init(title: "LUCK90%", percent: "-90%", endDate: Date(), info: nil, active: true)],
    products: [
        .init(price: 15000.0, title: "Куртка"),
        .init(price: 2000.0, title: "Джинсы")],
    paymentDiscount: nil, baseDiscount: nil)

class ViewController: UIViewController {
    
    private lazy var viewModel = ViewModel()
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.frame = view.bounds
            tableView.separatorStyle = .none
            tableView.register(ApplyPromoCodeCell.self, forCellReuseIdentifier: String(describing: ApplyPromoCodeCell.self))
            tableView.register(PromoCell.self, forCellReuseIdentifier: String(describing: PromoCell.self))
            tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
            tableView.register(TotalCell.self, forCellReuseIdentifier: String(describing: TotalCell.self))
            tableView.register(SecretPromoCell.self, forCellReuseIdentifier: String(describing: SecretPromoCell.self))
            return tableView
        }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Kefa", size: 16)
        label.text = "Оформление заказа"
        return label
    }()
    
    private lazy var titleUIView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        return uiView
    }()
    
    private var cellViewModels: [TableViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showOrder(order: order)
        viewModel.totalUpdate = { [weak self] index in
            guard let self else { return }
            guard let cellViewModels, !cellViewModels.isEmpty else {
                tableView.beginUpdates()
                tableView.reloadRows(at: [.init(row: index, section: 0)], with: .none)
                tableView.endUpdates()
            return
            }
        }
        viewModel.tableViewUpdate = { [weak self] in
            guard let self else { return }
                tableView.reloadData()
            }
        setupUI()
    }
    
    private func setupUI(){
        
        view.addSubview(titleUIView)
        NSLayoutConstraint.activate([
        titleUIView.heightAnchor.constraint(equalToConstant: 69)])
        titleUIView.translatesAutoresizingMaskIntoConstraints = false
        titleUIView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        titleUIView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        titleUIView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        titleUIView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
        titleLabel.centerXAnchor.constraint(equalTo: titleUIView.centerXAnchor)])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleUIView.bottomAnchor, constant: -5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleUIView.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
            
        case .applyPromo(let applay):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ApplyPromoCodeCell.self)) as? ApplyPromoCodeCell else {
                return UITableViewCell()
            }
            cell.viewModel = applay
            cell.nextViewController = { [weak self] in
                guard let self else { return }
                guard let clouser = self.viewModel.clouser else { return }
                self.navigationController?.pushViewController(ApplyPromoViewController(secretPromo: self.viewModel.secretPromocodes, closure: clouser), animated: true)
            }
            cell.selectionStyle = .none
            return cell
            
        case .promo(let promo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromoCell.self)) as? PromoCell else {
                return UITableViewCell()
            }
            
            cell.viewModel = promo
            cell.selectionStyle = .none
            cell.toggleValueChanged = { [weak self] value, id in
                guard let self else { return }
                self.viewModel.togglePromo(value: value, id: id)
            }
            return cell
            
        case .info(let info):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self)) as? TitleCell else {
                return UITableViewCell()
            }
            cell.viewModel = info
            cell.selectionStyle = .none
            return cell
            
        case .total(let total):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TotalCell.self)) as? TotalCell else {
                return UITableViewCell()
            }
            cell.viewModel = total
            cell.selectionStyle = .none
            return cell
            
        case .secretPromo(let secretPromo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SecretPromoCell.self)) as? SecretPromoCell else {
                return UITableViewCell()
            }
            cell.viewModel = secretPromo
            cell.selectionStyle = .none
            return cell
        default: return UITableViewCell()
        }
    
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: false)
        }
}
