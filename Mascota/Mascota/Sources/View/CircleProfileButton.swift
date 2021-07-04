//
//  CircleProfileView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

class CircleProfileButton: UIButton {
    private var type: BookType = .home
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setType(type: BookType) {
        self.type = type
        makeCircleView()
        layoutIfNeeded()
    }
    
    public func setProfileButton(image: UIImage) {
        makeCircleView()
        setImage(image, for: .normal)
    }
    
    public func makeCircleView() {
        layoutIfNeeded()
        layer.masksToBounds = true
        layer.cornerRadius = frame.width / 2
        
        layer.borderWidth = 1
        layer.borderColor = type.color().cgColor
    }
}
