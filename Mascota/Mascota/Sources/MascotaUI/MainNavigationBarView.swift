//
//  MainNavigationBarView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/04.
//

import UIKit

import SnapKit
import Then

class MainNavigationBarView: UIView {
    private var type: BookType = .home
    
    private lazy var bookPartLabel = UILabel().then {
        $0.font = .macoFont(type: .bold, size: 20)
        $0.textColor = type.color()
    }
    
    private lazy var bookTitleLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 20)
        $0.textColor = .macoBlack
    }
    
    private lazy var profileButton = CircleProfileButton(type: type)
    
    public init(type: BookType) {
        super.init(frame: CGRect.zero)
        self.type = type
        
        setNavigationBarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavigationBarView() {
        backgroundColor = .macoIvory
        
        addSubviews(bookPartLabel, bookTitleLabel, profileButton)
        
        profileButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(30)
        }

        bookPartLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        bookTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(bookPartLabel.snp.trailing).offset(6)
        }
        
    }
    
    //  Public Function

    public func setNavigationBarText(part: String? = nil, title: String) {
        if let part = part {
            _ = bookPartLabel.then {
                $0.text = part
            }
        }
        
        _ = bookTitleLabel.then {
            $0.text = title.maxLength(length: 11)
        }
    }
    
    func setNavigationBarButtonImage(url: String) {
        self.profileButton.setProfileButton(url: url)
    }
}
