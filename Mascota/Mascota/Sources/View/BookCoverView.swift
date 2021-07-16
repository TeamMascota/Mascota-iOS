//
//  BookCoverView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

class BookCoverView: UIView {
    
    private lazy var coverImageView = UIImageView()
    
    private lazy var verticalView = UIView().then {
        $0.backgroundColor = .macoOrange
    }
    
    private lazy var horizontalView = UIView().then {
        $0.backgroundColor = .macoOrange
    }
    
    private lazy var bookTitleLabel = UILabel().then {
        $0.font = .macoFont(type: .bold, size: 23)
        $0.textColor = .macoWhite
        $0.textAlignment = .right
    }
    
    private lazy var writerLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 17)
        $0.textColor = .macoWhite
        $0.textAlignment = .right
    }
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "icAppWhite")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var dimColorView = UIView().then {
        $0.backgroundColor = .macoBlack.withAlphaComponent(0.3)
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        
        initBookCoverView()
        
        setBookCoverView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initBookCoverView() {
        layer.masksToBounds = true
        layer.cornerRadius = Constant.round3
    }
    
    private func setBookCoverView() {
        
        addSubviews(coverImageView, dimColorView, verticalView, horizontalView, bookTitleLabel, writerLabel, logoImageView)
         
        verticalView.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.top.leading.bottom.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(verticalView.snp.trailing)
        }
        
        horizontalView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(verticalView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        writerLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(horizontalView.snp.bottom).offset(5)
        }
        
        logoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(52.5)
            $0.height.equalTo(43.2)
        }
        
        dimColorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    public func setTitleAndWriterLabel(title: String, author: String) {
        bookTitleLabel.text = title
        writerLabel.text = author
    }
    
    public func setBookCoverImage(cover: String?) {
        if let cover = cover {
            coverImageView.updateServerImage(cover)
        }
    }

}
