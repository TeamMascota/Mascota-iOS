//
//  RainbowBestSectionHeaderView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class RainbowBestSectionHeaderView: UIView {
    private lazy var imageView = UIImageView().then {
        $0.image = .actions
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .macoFont(type: .bold, size: 20)
        $0.textColor = .macoWhite
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 14)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .macoWhite
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setRainbowBestSectionHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRainbowBestSectionHeader() {
        addSubviews(imageView, titleLabel, contentLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalToSuperview().offset(19)
            $0.width.equalTo(44)
            $0.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.centerY.equalTo(imageView.snp.centerY)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(23)
            $0.trailing.equalToSuperview().offset(44)
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.bottom.equalToSuperview().inset(21)
        }
    }
    
    public func setHeaderText(title: String, text: String) {
        titleLabel.text = title
        contentLabel.text = text
    }
    
}
