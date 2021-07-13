//
//  ContentView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/06/30.
//

import UIKit

import SnapKit
import Then

class BookContentView: UIView {
    private var type: BookType = .home
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.sizeToFit()
        $0.textColor = .macoDarkGray
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.sizeToFit()
        $0.textColor = .macoDarkGray
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }

    private lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .macoGray
        $0.numberOfLines = 4
        $0.textAlignment = .left
    }

    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.sizeToFit()
        $0.textColor = .macoGray
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }

    public lazy var faceImageView = UIImageView().then {
        $0.image = UIImage(named: "emoDogAngry")
    }
    
    private lazy var logoView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        switch type {
        case .home:
            $0.image = UIImage(named: "appIconOrange")
        case .rainbow:
            $0.image = UIImage(named: "appIconBlue")
        }
    }
    
    public init(type: BookType = .home) {
        super.init(frame: CGRect.zero)
        self.type = type
        setContentView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentView() {
        addSubviews(titleLabel, subtitleLabel, contentLabel, dateLabel, faceImageView)
        
        addSubviews(logoView)
        
        logoView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(62)
            $0.height.equalTo(51)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(27)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(16)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().inset(20)
        }

        faceImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(33.2)
            $0.height.equalTo(24)
        }
    }
    
    public func setText(pageText: PageTextModel? = nil) {
        if let title = pageText?.title, let subtitle = pageText?.subtitle, let content = pageText?.content, let date = pageText?.date {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            contentLabel.text = content
            dateLabel.text = date

            contentLabel.setLineSpacing(lineHeightMultiple: 1.5)
            contentLabel.lineBreakMode = .byTruncatingTail

            [titleLabel, subtitleLabel, contentLabel, dateLabel, faceImageView].forEach {
                $0.isHidden = false
            }

            logoView.isHidden = true

        } else {
            logoView.isHidden = false

            [titleLabel, subtitleLabel, contentLabel, dateLabel, faceImageView].forEach {
                $0.isHidden = true
            }
        }
        
    }
}
