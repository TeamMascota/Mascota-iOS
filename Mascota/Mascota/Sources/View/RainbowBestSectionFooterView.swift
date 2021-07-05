//
//  RainbowBestSectionFooterView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class RainbowBestSectionFooterView: UIView {
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: "illustExample")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var bestDateLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 14)
        $0.textColor = .macoWhite
        $0.numberOfLines = 2
        $0.text = "코봉의 최고의 순간\n2020.06.05 ~ 2099.06.05"
    }
    
    private lazy var endLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 14)
        $0.textColor = .macoWhite
        $0.text = "1부 마치며"
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setRainbowBestSectionFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRainbowBestSectionFooter() {
        addSubviews(imageView, bestDateLabel, endLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(151)
            $0.width.equalTo(210)
        }
        
        bestDateLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(23)
            $0.bottom.equalToSuperview().inset(46)
        }
        
        endLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(46)
            $0.trailing.equalToSuperview().inset(23)
        }
        
    }
    
    public func setBestDateText(text: String) {
        endLabel.text = text
    }
    
}
