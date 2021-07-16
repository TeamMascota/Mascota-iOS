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
    private lazy var titleLabel = UILabel().then {
        if UIDevice.current.hasNotch {
            $0.font = .macoFont(type: .medium, size: 14)
        } else {
            $0.font = .macoFont(type: .medium, size: 13)
        }
        $0.text = "이야기 기록하기"
        $0.sizeToFit()
        $0.textColor = .macoDarkGray
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    
    private lazy var emojiStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private lazy var lineStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
//        $0.spacing = 26
    }
    
    private lazy var emoji = EmojiStyle()
    
    private lazy var writingImageView = UIImageView().then {
        $0.image = UIImage(named: "btnWriting")
    }
    
    private lazy var textLabel = UILabel().then {
        
        if UIDevice.current.hasNotch {
            $0.attributedText = "작가님의 오늘 하루는\n어땠나요?".attributedString(font: .macoFont(type: .regular, size: 14), color: .macoLightGray, customLineHeight: 26)
        } else {
            $0.attributedText = "작가님의 오늘 하루는\n어땠나요?".attributedString(font: .macoFont(type: .regular, size: 13), color: .macoLightGray, customLineHeight: 26)
        }
        
        $0.numberOfLines = 2
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setContentView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentView() {
        addSubviews(titleLabel, emojiStackView, lineStackView, writingImageView, textLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(14)
        }
        
        for i in 0...5 {
            let imageView = UIImageView()
            imageView.image = emoji.getEmoji(kind: 1, feeling: i)
            emojiStackView.addArrangedSubviews(imageView)
            imageView.snp.makeConstraints {
                $0.width.equalTo(20)
                $0.height.equalTo(15)
            }
        }
        
        emojiStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-15)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(15)
        }
        
        for _ in 0...1 {
            let line = UIView().then {
                $0.backgroundColor = .macoOrange
            }
            lineStackView.addArrangedSubviews(line)
            line.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.leading.trailing.equalToSuperview()
            }
        }
        
        for _ in 0...1 {
            let line = UIView().then {
                $0.backgroundColor = .macoOrange
            }
            lineStackView.addArrangedSubviews(line)
            line.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.leading.equalToSuperview()
                $0.width.equalTo(lineStackView.snp.width).dividedBy(2)
            }
        }
        
        lineStackView.snp.makeConstraints {
            $0.top.equalTo(emojiStackView.snp.bottom).inset(-30)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(45)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(lineStackView.snp.top).inset(-23)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        writingImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(23)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(lineStackView.snp.width).dividedBy(2.5)
        }
    }
    
    public func setText() {
        
    }
}
