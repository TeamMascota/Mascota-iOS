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
    
    private lazy var bookPageView = BookRainbowPageView()
    
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
        
        addSubviews(bookPageView)
        
        bookPageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(225)
            $0.bottom.equalToSuperview()
        }
        
        bookPageView.setContentText()
    
    }
    
    public func setContentText(pages: [PageTextModel]?) {
        bookPageView.setContentText(pages: pages)
    }

}
