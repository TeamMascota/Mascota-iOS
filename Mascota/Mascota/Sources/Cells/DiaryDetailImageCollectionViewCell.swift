//
//  DiaryDetailImageCollectionViewCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/11.
//

import UIKit

class DiaryDetailImageCollectionViewCell: UICollectionViewCell {
    public static let identifier = "DiaryDetailImageCollectionViewCell"
    
    private let menuTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .white
        $0.text = "Collection"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        
        addSubview(menuTitle)
        
        menuTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(title: String) {
        menuTitle.text = title
    }
}
