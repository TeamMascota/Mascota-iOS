//
//  ProfileNameButton.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/13.
//

import UIKit

class ProfileNameButton: UIButton {
    private lazy var petImageView = UIImageView().then {
        $0.image = .checkmark
        $0.backgroundColor = .cyan
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.text = "ㅋㅋ"
        $0.font = .macoFont(type: .regular, size: 10)
        $0.textColor = .white
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setButton(color: .macoLightGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setButton(color: .macoBlue)
            } else {
                setButton(color: .macoLightGray)
            }
        }
    }
    
    private func setButton (color: UIColor) {
        layer.masksToBounds = true
        layer.cornerRadius = Constant.round3
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        backgroundColor = color
        
        addSubviews(petImageView, nameLabel)
        
        petImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(petImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-4)
            $0.centerX.equalToSuperview()
        }
    }
    
}
