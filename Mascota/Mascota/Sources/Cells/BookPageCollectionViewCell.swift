//
//  BookPageCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/05.
//

import UIKit

class BookPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var superView: UIView!
    private lazy var bookHomePageView: BookHomePageView = BookHomePageView().then {
        $0.setContentText()
    }
    
    private func layoutComponents() {
        self.contentView.addSubview(bookHomePageView)
        bookHomePageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(15)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-15)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(15)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutComponents()
        // Initialization code
    }

}
