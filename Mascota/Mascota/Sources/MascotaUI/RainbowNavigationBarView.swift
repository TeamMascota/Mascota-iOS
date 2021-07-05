//
//  RainbowNavigationBarView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

enum NavigationStyle {
    case left
    case right
    case leftAndRight
}

class RainbowNavigationBarView: UIView {
    private lazy var style = NavigationStyle.leftAndRight
    
    public lazy var backButton = UIButton().then {
        $0.setBackgroundImage(.add, for: .normal) // 이미지 넣기
    }
    
    public lazy var closeButton = UIButton().then {
        $0.setBackgroundImage(.remove, for: .normal) // 이미지 넣기
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 17)
        $0.textColor = .macoWhite
    }
    
    private lazy var underLineView = UIView().then {
        $0.backgroundColor = .macoWhite
    }
    
    public init(style: NavigationStyle, title: String) {
        super.init(frame: CGRect.zero)
        self.style = style
        titleLabel.text = title
        setNavigationBarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavigationBarView() {
        backgroundColor = .macoBlue
        
        addSubviews(titleLabel, underLineView)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        switch style {
        case .left:
            addSubviews(backButton)
            backButton.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
                $0.centerY.equalToSuperview()
            }
            
        case .right:
            addSubviews(closeButton)
            closeButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
            
        case .leftAndRight:
            addSubviews(backButton, closeButton)
            backButton.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16)
                $0.centerY.equalToSuperview()
            }
            closeButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
        }
        
    }
}
