//
//  RainbowCommentViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

class RainbowCommentViewController: UIViewController {
    
    private lazy var rainbowNavigationBar = RainbowNavigationBarView(style: .right, title: "이별하는 무지개 다리")
    
    private lazy var contentLabel = UILabel().then {
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.font = .macoFont(type: .regular, size: 16)
        $0.textColor = .macoWhite
    }
    
    private lazy var macoImageView = UIImageView().then {
        $0.image = UIImage(named: "illustExample")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var nextButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("다음", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowCommentViewController()
        
        setRainbowNavigationBar()
        setImageVIew()
        setButton()
        setContentLabel()
    }
    
    private func initRainbowCommentViewController() {
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
    
    private func setImageVIew() {
        view.addSubviews(macoImageView)
        
        macoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
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
    
    private func setContentLabel() {
        contentLabel.text = "작가님과 함께했던 2318화의 이야기 속에서 \n코봉이는 의젓하고 당당한 고양이로서 \n행복한 인생을 보낼 수 있었어요. \n그리고 지금은 작가님보다 한 발 앞서서 \n먼저 무지개 다리로 가 친구들과 함께 \n작가님을 기다리기로 했습니다.  \n그동안 행복한 일상을 선물해주셔서 감사합니다. \n코봉이가 느꼈던 최고의 순간들을 모아봤어요."
        contentLabel.setLineSpacing(lineSpacing: 8)
        
        view.addSubviews(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(rainbowNavigationBar.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(23)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
}
