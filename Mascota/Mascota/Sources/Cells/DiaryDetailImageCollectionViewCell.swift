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
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(image: UIImage) {
        imageView.image = image
    }
}
