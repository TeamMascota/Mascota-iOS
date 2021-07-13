//
//  CustomCollectionAlertView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/12.
//

import UIKit

class CustomCollectionAlertView: UIView {
    
    private lazy var underLineView = UIView().then {
        $0.backgroundColor = .macoLightGray
    }
    
    private lazy var title = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 17)
        $0.text = "이별의 단계"
    }
    
    private lazy var subtitle = UILabel().then {
        $0.font = .macoFont(type: .regular, size: 14)
        $0.text = "어느 주인공과 이별했는지 알려주세요"
    }
    
    private lazy var hStackView = UIStackView().then {
        $0.alignment = .leading
        $0.spacing = 4
        $0.axis = .horizontal
        $0.distribution = .fillEqually
      
    }
    
    public lazy var petId: String = ""
    
    public init() {
        super.init(frame: CGRect.zero)
    
        initCustomCollectionAlertView()
        setPetProfileStackView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCustomCollectionAlertView() {
        addSubviews(underLineView, title, subtitle, hStackView)
        
        underLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
        
        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        subtitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(67)
        }
        
        hStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            
            $0.top.equalToSuperview().offset(113)
            $0.height.equalTo(82)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
    @objc
    func tapProfileNameButton(_ sender: UIButton) {
       
        let buttonArray = hStackView.arrangedSubviews
        for button in buttonArray {
            if let button = button as? UIButton {
                button.isSelected = false
            }
        }
        
        petId = String(sender.tag)
        sender.isSelected = !sender.isSelected
    }
    
    func setPetProfileStackView() {
        for i in 0...3 {
            let profileNameButton = ProfileNameButton()
            hStackView.addArrangedSubviews(profileNameButton)
            profileNameButton.tag = i
            
            profileNameButton.snp.makeConstraints {
                $0.width.equalTo(62)
                $0.height.equalTo(82)
            }
            
            profileNameButton.addTarget(self, action: #selector(tapProfileNameButton(_:)), for: .touchUpInside)
        }
        
    }
}
