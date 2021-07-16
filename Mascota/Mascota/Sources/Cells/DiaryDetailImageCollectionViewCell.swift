//
//  DiaryDetailImageCollectionViewCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/11.
//

import UIKit

class DiaryDetailImageCollectionViewCell: UICollectionViewCell {
    public static let identifier = "DiaryDetailImageCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let topLineView = UIView()
    private let underLindeView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(imageView, topLineView, underLindeView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        setLineColor()
        
        topLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        underLindeView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(url: String) {
        self.imageView.updateServerImage(url)
    }
    
    public func setLineColor(color: UIColor = .macoOrange) {
        topLineView.backgroundColor = color
        underLindeView.backgroundColor = color
    }
}
