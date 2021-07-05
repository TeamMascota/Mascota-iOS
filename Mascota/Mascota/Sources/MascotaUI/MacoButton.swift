//
//  MacoButton.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

enum MacoButtonType {
    case white
    case orange
    case blue
    
    func color() -> UIColor {
        switch self {
        case .white:
            return .macoWhite
        case .orange:
            return .macoOrange
        case .blue:
            return .macoBlue
        }
    }

}

class MacoButton: UIButton {
    private lazy var type: MacoButtonType = .blue
    
    public init(color: MacoButtonType) {
        super.init(frame: CGRect.zero)
        
        self.type = color
        setMacoButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMacoButton () {
        backgroundColor = type.color()
        layer.masksToBounds = true
        layer.cornerRadius = Constant.round3
    }
    
    public func setMacoButtonTitle(_ title: String?, for state: UIControl.State) {
        setTitle(title, for: state)
        titleLabel?.font = .macoFont(type: .medium, size: 17)
        
        switch type {
        case .white:
            titleLabel?.textColor = .macoBlue
        case .orange, .blue:
            titleLabel?.textColor = .macoWhite
        }
    }
}
