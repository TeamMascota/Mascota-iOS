//
//  BookRainbowPageView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/02.
//

import UIKit

import SnapKit
import Then

class BookRainbowPageView: BookPageView {
    
    private lazy var leftPageView = BookContentView()
    private lazy var rightPageView = BookContentView()
    
    private lazy var backgroundView = BookPageView(type: .rainbow)
    
    public init() {
        super.init(type: .rainbow)
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
    
    public func setContentText(pages: [PageTextModel]? = nil) {
        
        switch pages?.count {
        case 0:
            leftPageView.setText()
            rightPageView.setText()
        case 1:
            leftPageView.setText(pageText: pages?[0])
            rightPageView.setText()
        case 2:
            leftPageView.setText(pageText: pages?[0])
            rightPageView.setText(pageText: pages?[1])
        default:
            break
        }
    }
    
}
