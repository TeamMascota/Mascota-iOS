//
//  BaseViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    private var type: BookType = .home
    
    private lazy var topBarView = UIView().then {
        $0.backgroundColor = .macoIvory
    }
    
    private lazy var bookPartLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 23)
    }
    
    private lazy var bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 23)
        $0.textColor = .macoBlack
    }
    
    private lazy var profileButton = CircleProfileButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopBarView()
    }
    
    private func setTopBarView() {
        view.addSubviews(topBarView, bookPartLabel, bookTitleLabel, profileButton)
        
        profileButton.snp.makeConstraints {
            $0.centerY.equalTo(topBarView)
            $0.trailing.equalTo(topBarView.snp.trailing).inset(16)
            $0.height.width.equalTo(30)
        }
        
        topBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topBarHeight)
        }
        
        bookPartLabel.snp.makeConstraints {
            $0.centerY.equalTo(topBarView)
            $0.leading.equalTo(topBarView.snp.leading).offset(16)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(topBarView)
            $0.leading.equalTo(bookPartLabel.snp.trailing).offset(6)
        }
        
    }
    
    // MARK: - public Functions
    public func setNavigationBar(type: BookType) {
        self.type = type
        
        _ = bookPartLabel.then {
            $0.text = type.text()
            $0.textColor = type.color()
        }
        
        profileButton.setType(type: type)
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .macoIvory
    }
    
    public func setBookTitleLabel(text: String) {
        _ = bookTitleLabel.then {
            $0.text = text.maxLength(length: 11)
        }
    }
    
    public func getTopBarBottomConstraint() -> ConstraintItem {
        return topBarView.snp.bottom
    }
    
}
