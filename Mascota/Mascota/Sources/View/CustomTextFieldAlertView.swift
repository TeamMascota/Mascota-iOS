//
//  CustomTextFieldAlertView.swift
//  Mascota
//
//  Created by apple on 2021/07/09.
//

import UIKit

class CustomTextFieldAlertView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertTextField: UITextField!
    @IBOutlet weak var textFieldCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        let loadFromXib = Bundle.main.loadNibNamed(AppConstants.Views.customTextFieldAlertView, owner: self, options: nil)?[0] as? UIView ?? UIView()
        loadFromXib.frame = self.bounds
        addSubview(loadFromXib)
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func setAttributedTitle(attributedText: NSAttributedString) {
        titleLabel.attributedText = attributedText
    }
    
    func setTextFieldCountLabel(length: Int) {
        self.textFieldCountLabel.text = "\(length)/11"
    }
    
    func initializeComponents(title: String?, textField: String?) {
        self.titleLabel.text = title ?? ""
        self.alertTextField.text = textField ?? ""
        self.textFieldCountLabel.text = "\(textField?.count ?? 0)/11"
        
    }
}
