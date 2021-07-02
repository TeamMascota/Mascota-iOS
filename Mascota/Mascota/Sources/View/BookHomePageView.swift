//
//  BookHomePageView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/02.
//

import UIKit

import SnapKit
import Then

class BookHomePageView: BookPageView {
    
    private lazy var leftPageView = BookContentView()
    private lazy var rightPageView = BookWriteView()
    
    private lazy var backgroundView = BookPageView(type: .home)
    
    public init() {
        super.init(type: .home)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubviews(backgroundView, leftPageView, rightPageView)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        leftPageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(backgroundView.centerLine.snp.leading)
        }
        
        rightPageView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(backgroundView.centerLine.snp.trailing)
        }
    }
    
    public func setContentText(page: PageTextModel? = nil) {
        leftPageView.setText(pageText: page)
    }
}
