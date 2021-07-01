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
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.sizeToFit()
        $0.numberOfLines = 0
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.sizeToFit()
        $0.numberOfLines = 0
    }

    private lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.sizeToFit()
        $0.numberOfLines = 0

    }

    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.sizeToFit()
        $0.numberOfLines = 0

    }

    private lazy var faceImageView = UIImageView().then {
        $0.image = .checkmark
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .macoYellow
        setContentView()
        setText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContentView() {
        addSubviews(titleLabel, subtitleLabel, contentLabel, dateLabel, faceImageView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        faceImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().offset(5)
        }
    }
    
    public func setText() {
        titleLabel.text = "6월어쩌구이야기"
        subtitleLabel.text = "제목이들어갈자리"
        contentLabel.text = "내용이들어갈자리인데덜덜덩"
        dateLabel.text = "몇일이겡"
        
    }
}
