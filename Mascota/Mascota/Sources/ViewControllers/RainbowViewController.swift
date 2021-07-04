//
//  RainbowViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/01.
//

import UIKit

import SnapKit
import Then

class RainbowViewController: BaseViewController {
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar(type: .home)
        setBookTitleLabel(text: "헤헤헤헤헤헤헿헤헤헤ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ")
    }
    
    private func setView() {
        
        view.addSubviews(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(getTopBarBottomConstraint())
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
    }

}
