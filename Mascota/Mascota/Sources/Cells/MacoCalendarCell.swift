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
    
    private let emogiImageView = UIImageView()

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
        setNumberLabel(count: -1)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emogiImageView.image = nil
        numberLabel.text = nil
    }
    
    func setMacoCalendarCell() {
        
        contentView.addSubviews(emogiImageView, circleNumberView)
        
        circleNumberView.addSubviews(numberLabel)
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        if UIDevice.current.hasNotch {
            self.titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(8)
                $0.centerX.equalToSuperview()
            }
            
            emogiImageView.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(8)
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
            self.titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(5)
                $0.centerX.equalToSuperview()
            }
            
            emogiImageView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(26)
                $0.height.equalTo(20)
            }
            
            circleNumberView.snp.makeConstraints {
                $0.trailing.equalTo(emogiImageView.snp.trailing).inset(-5)
                $0.bottom.equalTo(emogiImageView.snp.bottom).inset(12)
                $0.width.height.equalTo(17)
            }
            
        }
    }
    
    public func setNumberLabel(count: Int) {
        if count == -1 {
            emogiImageView.isHidden = true
            circleNumberView.isHidden = true
        } else if count == 0 {
            emogiImageView.isHidden = false
            emogiImageView.image = UIImage(named: "emoEmpty")
            circleNumberView.isHidden = true
        } else if count == 1 {
            emogiImageView.isHidden = false
            emogiImageView.image = UIImage(named: "emoDogAngry")
            circleNumberView.isHidden = true
        } else {
            emogiImageView.isHidden = false
            emogiImageView.image = UIImage(named: "emoDogAngry")
            circleNumberView.isHidden = false
            numberLabel.text = String(count)
        }
    }
    
}
    
