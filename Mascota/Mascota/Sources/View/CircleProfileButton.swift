//
//  CircleProfileView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

class CircleProfileButton: UIButton {
    private var type: BookType = .home
    
    public init(type: BookType) {
        super.init(frame: CGRect.zero)
        self.type = type
        
        makeCircleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setProfileButton(image: UIImage) {
        makeCircleView()
        setImage(image, for: .normal)
    }
    
    private func makeCircleView() {
        layer.masksToBounds = true
        layer.cornerRadius = 15
        
        layer.borderWidth = 1
        layer.borderColor = type.color().cgColor
    }
}
