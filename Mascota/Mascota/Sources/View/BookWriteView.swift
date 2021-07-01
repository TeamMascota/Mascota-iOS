//
//  BookWriteView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/01.
//

import UIKit

import SnapKit
import Then

class BookWriteView: UIView {
    private lazy var text = UILabel().then {
        $0.text = "글작성으로이동하는뷰입니당"
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .white
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .black
        
        setContentView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentView() {
        addSubviews(text)
        text.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func setText() {
        
    }
}
