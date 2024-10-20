//
//  TitleCell.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 22.10.2024.
//

import UIKit

class TitleCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.TitleInfo? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var indentionUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        infoLabel.text = viewModel.info
        
    }

    private func setupUI() {
        contentView.addSubview(indentionUIView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
        indentionUIView.heightAnchor.constraint(equalToConstant: 16)])
        indentionUIView.translatesAutoresizingMaskIntoConstraints = false
        indentionUIView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        indentionUIView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        indentionUIView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: indentionUIView.bottomAnchor, constant: 24).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -42).isActive = true
        
        NSLayoutConstraint.activate([
        infoLabel.heightAnchor.constraint(equalToConstant: 40)])
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
}
