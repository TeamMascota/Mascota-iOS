//
//  CharacterMoodCollectionReusableView.swift
//  Mascota
//
//  Created by apple on 2021/07/10.
//

import UIKit

import Then
import SnapKit

class CharacterMoodCollectionReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 17)
        $0.text = "주인공 및 기분 선택"
        $0.textAlignment = .left
        $0.textColor = UIColor.darkGray
    }
    
    let subtitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.text = "오늘 이야기의 주인공을 모두 선택해 주세요"
        $0.textAlignment = .left
        $0.textColor = UIColor.macoGray
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutComponents()
        // Initialization code
    }
    
    private func layoutComponents() {
        self.backgroundColor = UIColor.macoIvory
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        subtitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom)
            $0.leading.equalTo(self.snp.leading)
        }
        
        titleLabel.snp.makeConstraints {
            
            $0.bottom.equalTo(subtitleLabel.snp.top)
            $0.leading.equalTo(self.snp.leading)
        }
    }
    
}
