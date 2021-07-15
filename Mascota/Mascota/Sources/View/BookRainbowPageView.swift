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
    
    public func setContentText(pages: [MemoryModel?]) {

        switch pages.count {
        case 1:
            guard let page = pages[0] else {return}
            leftPageView.setText(pageText: convertPageTextModel(page: page))
            rightPageView.setText()
        case 2:
            guard let leftPage = pages[0] else { return }
            guard let rightPage = pages[1] else { return }
            leftPageView.setText(pageText: convertPageTextModel(page: leftPage))
            rightPageView.setText(pageText: convertPageTextModel(page: rightPage))
        default:
            leftPageView.setText()
            rightPageView.setText()
        }
    }
    
    private func convertPageTextModel(page: MemoryModel) -> PageTextModel {
        var title: String?
        var subtitle: String?
        var content: String?
        var date: String?
        
        let rawDate = page.date
        DateProcessing.getDate(rawDate: rawDate) { dateVO in
            title = "\(String(dateVO.year))년 \(String(dateVO.month))월의 이야기"
        }
        
        subtitle = page.title
        content = page.contents
        
        DateProcessing.getDate(rawDate: rawDate) { dateVO in
            date = "\(String(dateVO.year)).\(String(format: "%02d", dateVO.month)).\(String(format: "%02d", dateVO.day))"
        }
        
        return PageTextModel(title: title, subtitle: subtitle, content: content, date: date)
    }
    
}
