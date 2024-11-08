//
//  CheckBoxAnonymouslyUIButton.swift
//  ProductScreen
//
//  Created by Максим Игоревич on 08.11.2024.
//

import UIKit

class CheckBoxAnonymouslyUIButton: UIButton {
    
    public var clouser: ((Bool) -> Void)?
    
    private var viewModel: TableViewModel.ViewModelType.Review?
    
    let checkedImage = UIImageView(image: UIImage(named: "checkBoxTrue"))
    let uncheckedImage = UIImageView(image: UIImage(named: "checkBoxFalse"))

    var isChecked: Bool = false {
        didSet {
            self.setImage(isChecked ? checkedImage.image : uncheckedImage.image, for: .normal)
            clouser?(isChecked)
        }
    }
    
    public func initViewModel(viewModel: TableViewModel.ViewModelType.Review){
        self.viewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.isChecked = false
        self.setImage(uncheckedImage.image, for: .normal)
        self.imageView?.contentMode = .scaleToFill
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.isChecked = false
        self.setImage(uncheckedImage.image, for: .normal)
        self.imageView?.contentMode = .scaleToFill
    }

    @objc func buttonTapped() {
        isChecked.toggle()
    }
}
