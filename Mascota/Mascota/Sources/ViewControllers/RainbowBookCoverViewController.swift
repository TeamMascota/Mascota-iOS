//
//  RainbowBookCoverViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

class RainbowBookCoverViewController: UIViewController {

    private lazy var rainbowNavigationBar = RainbowNavigationBarView(style: .leftAndRight, title: "이별하는 무지개 다리")
    
    private lazy var nextButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("다음", for: .normal)
    }
    
    private lazy var episodeLabel = UILabel().then {
        $0.textColor = .macoWhite
        $0.font = .macoFont(type: .bold, size: 23)
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.textColor = .macoWhite
    }
    
    private lazy var bookCoverView = BookCoverView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowBookCoverViewController()
        
        setAddTarget()
        setRainbowNavigationBar()
        setLabel()
        setBookCoverView()
        setButton()
    }
    
    private func setAddTarget() {
        rainbowNavigationBar.backButton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        rainbowNavigationBar.closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
    }
    
    private func initRainbowBookCoverViewController() {
        view.backgroundColor = .macoBlue
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(rainbowNavigationBar)
        
        rainbowNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topBarHeight)
        }
    }
    
    private func setButton() {
        view.addSubviews(nextButton)
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
        }
    }
    
    private func setLabel() {
        view.addSubviews(episodeLabel, dateLabel)
        
        episodeLabel.snp.makeConstraints {
            $0.top.equalTo(rainbowNavigationBar.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(23)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(episodeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(23)
        }

        let episodeAttr = NSMutableAttributedString()
        episodeAttr.append("지금까지 썼던 책은 ".convertColorFont(color: .macoWhite, fontSize: 20, type: .medium))
        episodeAttr.append("총 1234화".convertColorFont(color: .macoWhite, fontSize: 20, type: .bold))

        episodeLabel.attributedText = episodeAttr

        let dateAttr = NSMutableAttributedString()
        dateAttr.append("함께 보낸 날은 총 ".convertColorFont(color: .macoWhite, fontSize: 20, type: .medium))
        dateAttr.append("총 5160일".convertColorFont(color: .macoWhite, fontSize: 20, type: .bold))

        dateLabel.attributedText = dateAttr
    }
    
    private func setBookCoverView() {
        view.addSubviews(bookCoverView)
        
        if UIDevice.current.hasNotch {
            bookCoverView.snp.makeConstraints {
                $0.top.equalTo(dateLabel.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(28)
                $0.trailing.equalToSuperview().inset(28)
                $0.height.equalTo(bookCoverView.snp.width).multipliedBy(1.4)
            }
        } else {
            bookCoverView.snp.makeConstraints {
                $0.top.equalTo(dateLabel.snp.bottom).offset(20)
                $0.bottom.equalToSuperview().inset(111)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(bookCoverView.snp.height).multipliedBy(0.7)
            }
        }
        
        bookCoverView.setTitleAndWriterLabel(title: "모여봐요 코봉의 숲", writer: "작가 최소은")
    }
    
}

extension RainbowBookCoverViewController {
    
    @objc
    func tapCloseButton() {
        print("tapCloseButton")
    }
    
    @objc
    func tapBackButton() {
        print("tapBackButton")
    }
    
    @objc
    func tapNextButton() {
        print("tapNextButton")
    }
    
}
