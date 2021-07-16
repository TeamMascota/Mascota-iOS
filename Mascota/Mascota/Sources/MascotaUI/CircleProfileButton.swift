//
//  CircleProfileView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

class CircleProfileButton: UIButton {
    private var type: BookType = .home
    private var profileImageView = UIImageView()
    
    public init(type: BookType) {
        super.init(frame: CGRect.zero)
        self.type = type
        
        makeCircleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setProfileButton(url: String) {
        makeCircleView()
        profileImageView.updateServerImage(url)
    }
    
    private func makeCircleView() {
        addSubviews(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 15
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = type.color().cgColor
    }
}
