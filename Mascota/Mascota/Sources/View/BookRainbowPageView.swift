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
    
    public lazy var leftPageView = BookContentView(type: .rainbow)
    public lazy var rightPageView = BookContentView(type: .rainbow)
    
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
    
    public func setContentText(pages: [PageTextModel?]) {

        switch pages.count {
        case 1:
            guard let page = pages[0] else { return }
            leftPageView.setText(pageText: page)
            rightPageView.setText()
        case 2:
            guard let leftPage = pages[0] else { return }
            guard let rightPage = pages[1] else { return }
            leftPageView.setText(pageText: leftPage)
            rightPageView.setText(pageText: rightPage)
        default:
            leftPageView.setText()
            rightPageView.setText()
        }
    }
    
}
