//
//  RainbowBookTableViewCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class RainbowBookPageTableViewCell: UITableViewCell {
    
    public lazy var bookPageView = BookRainbowPageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setRainbowBookTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setRainbowBookTableViewCell() {
        backgroundColor = .clear
        
        contentView.addSubviews(bookPageView)
        
        let bookHeight = (Constant.DeviceSize.width - 32) * 0.6
        
        bookPageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(Int(bookHeight))
            $0.bottom.equalToSuperview()
        }
        
        bookPageView.setContentText(pages: [])
    
    }
    
    public func setContentText<T>(pages: [T?]) {
        if pages is [MemoryModel?] {
            guard let pages = pages as? [MemoryModel?] else { return }
            bookPageView.setContentText(pages: convertMemoryModelToPageTextModel(pages: pages))
        } else if pages is [DiaryModel?] {
            guard let pages = pages as? [DiaryModel?] else { return }
            bookPageView.setContentText(pages: convertDiaryModelToPageTextModel(pages: pages))
        }
    }
    
    private func convertMemoryModelToPageTextModel(pages: [MemoryModel?]) -> [PageTextModel] {
        var pageTextModels: [PageTextModel] = []
        
        for i in 0...pages.count - 1 {
            var title: String?
            var subtitle: String?
            var content: String?
            var date: String?
            
            if let rawDate = pages[i]?.date {
                DateProcessing.getDate(rawDate: rawDate) { dateVO in
                    title = "\(String(dateVO.year))년 \(String(dateVO.month))월의 이야기"
                }
                
                subtitle = pages[i]?.title
                content = pages[i]?.contents
                
                DateProcessing.getDate(rawDate: rawDate) { dateVO in
                    date = "\(String(dateVO.year)).\(String(format: "%02d", dateVO.month)).\(String(format: "%02d", dateVO.day))"
                }
                
                pageTextModels.append(PageTextModel(title: title, subtitle: subtitle, content: content, date: date))
            }
        }
        
        return pageTextModels
    }
    
    private func convertDiaryModelToPageTextModel(pages: [DiaryModel?]) -> [PageTextModel] {
        var pageTextModels: [PageTextModel] = []
        
        for i in 0...pages.count - 1 {
            var title: String?
            if let chapter = pages[i]?.chapter,
               let episode = pages[i]?.episode,
               let subtitle = pages[i]?.title,
               let content = pages[i]?.contents,
               let date = pages[i]?.date {
            
                title = "\(String(describing: chapter))장 \(String(describing: episode))화"
                pageTextModels.append(PageTextModel(title: title, subtitle: subtitle, content: content, date: date))
            }
        }
        
        return pageTextModels
    }

}
