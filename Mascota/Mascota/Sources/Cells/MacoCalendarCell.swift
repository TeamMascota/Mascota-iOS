//
//  MacoCalendarCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/13.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class MacoCalendarCell: FSCalendarCell {
    static let identifier = "MacoCalendarCell"
    
    private let circleView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    private let emogiImageView = UIImageView().then {
        $0.image = UIImage(named: "emoDogAngry")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let circleNumberView = UIView().then {
       
        $0.backgroundColor = .macoOrange.withAlphaComponent(0.5)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 17 / 2
        
    }
    
    public let numberLabel = UILabel().then {
        $0.textColor = .macoWhite
        $0.text = "1"
        $0.font = .macoFont(type: .regular, size: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMacoCalendarCell()
    }
    
    func setMacoCalendarCell() {
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        contentView.addSubviews(emogiImageView, circleNumberView)
        
        circleNumberView.addSubviews(numberLabel)
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        if UIDevice.current.hasNotch {
            emogiImageView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(39)
                $0.height.equalTo(30)
            }
            
            circleNumberView.snp.makeConstraints {
                $0.trailing.equalTo(emogiImageView.snp.trailing)
                $0.bottom.equalTo(emogiImageView.snp.bottom).inset(22)
                $0.width.height.equalTo(17)
            }
            
        } else {
            emogiImageView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(26)
                $0.height.equalTo(20)
            }
            
            circleNumberView.snp.makeConstraints {
                $0.trailing.equalTo(emogiImageView.snp.trailing)
                $0.bottom.equalTo(emogiImageView.snp.bottom).inset(12)
                $0.width.height.equalTo(17)
            }
            
        }
       
    }
    
}
    
