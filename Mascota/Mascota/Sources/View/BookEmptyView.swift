//
//  BookEmptyView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/01.
//

import UIKit

import SnapKit
import Then

class BookEmptyView: UIView {
    private lazy var logoView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .checkmark // 이미지 넣기
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setEmptyView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setEmptyView() {
        addSubviews(logoView)
        
        logoView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(62 / Constant.DesignSize.width * Constant.Size.width)
            $0.height.equalTo(51 / Constant.DesignSize.height * Constant.Size.height)
        }
    }
    
}
