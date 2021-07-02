//
//  BookPageView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/06/30.
//

import UIKit

import SnapKit
import Then

enum BookType {
    case home
    case rainbow
    
    fileprivate func color() -> UIColor {
        switch self {
        case .home:
            return .macoOrange
        case .rainbow:
            return .macoBlue
        }
    }
    
}

class BookPageView: UIView {
    
    private lazy var color = UIColor.macoOrange
    
    private lazy var backgroundView = UIView().then {
        $0.layer.borderWidth = Constant.border1
        $0.layer.cornerRadius = Constant.round5
        $0.layer.borderColor = color.cgColor
        $0.layer.masksToBounds = true
    }
    
    private lazy var frontView = UIView().then {
        $0.layer.borderWidth = Constant.border1
        $0.layer.cornerRadius = Constant.round5
        $0.layer.borderColor = color.cgColor
        $0.layer.masksToBounds = true
        $0.backgroundColor = .macoIvory
    }
    
    public lazy var centerLine = UIView().then {
        $0.backgroundColor = color
    }
    
    public init(type: BookType) {
        super.init(frame: CGRect.zero)
        self.color = type.color()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubviews(backgroundView, frontView, centerLine)
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        
        frontView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        centerLine.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.equalTo(frontView.snp.top)
            $0.bottom.equalTo(backgroundView.snp.bottom)
            $0.centerX.equalTo(frontView)
        }
        
    }
}
