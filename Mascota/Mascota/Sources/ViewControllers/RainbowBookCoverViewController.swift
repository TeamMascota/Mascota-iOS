//
//  RainbowBookCoverViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

class RainbowBookCoverViewController: UIViewController {
    
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
    
    private lazy var backButton = UIBarButtonItem().then {
        $0.backBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapBackButton(_:)))
    }
    
    private lazy var closeButton = UIBarButtonItem().then {
        $0.closeBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapCloseButton(_:)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowBookCoverViewController()
        
        setAddTarget()
        setLabel()
        setBookCoverView()
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRainbowNavigationBar()
    }
    
    private func setAddTarget() {
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
    }
    
    private func initRainbowBookCoverViewController() {
        view.backgroundColor = .macoBlue
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoBlue, tintColor: .macoWhite, underLineColor: .macoWhite)
        navigationItem.setTitle(title: "무지개 다리")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
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
    func tapBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func tapCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        navigationController?.pushViewController(RainbowBestViewController(), animated: true)
    }
    
}
