//
//  PetEmotionCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/11.
//

import UIKit

import SnapKit
import Then

class PetEmotionCollectionViewCell: UICollectionViewCell {
    let topSepartor: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoLightGray
    }
    
    let bottomSepartor: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoLightGray
    }
    
    let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .medium, size: 17)
        $0.textColor = UIColor.macoDarkGray
        $0.textAlignment = .left
    }
    
    let deleteButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "icDelete"), for: .normal)
    }
    
    let emotionCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                     collectionViewLayout: UICollectionViewFlowLayout().then {
                                                                        $0.scrollDirection = .horizontal
                                                                     }).then {
        
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = UIColor.macoIvory
        $0.allowsMultipleSelection = true
        $0.allowsSelection = false
                                                                    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
