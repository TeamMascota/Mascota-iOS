//
//  CustomLabelAlertView.swift
//  Mascota
//
//  Created by apple on 2021/07/09.
//

import UIKit

class CustomLabelAlertView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func setAttributedTitle(attributedText: NSAttributedString) {
        titleLabel.attributedText = attributedText
    }
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }
    
    func setAttributedDescription(attributedText: NSAttributedString) {
        descriptionLabel.attributedText = attributedText
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.white
        let viewFromXib = Bundle.main.loadNibNamed(AppConstants.Views.customLabelAlertView, owner: self, options: nil)![0] as? UIView ?? UIView()
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    
    
}
