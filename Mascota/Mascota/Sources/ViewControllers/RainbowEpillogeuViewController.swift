//
//  RainbowEpillogeuViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

class RainbowEpillogeuViewController: UIViewController {
    
    private lazy var rainbowNavigationBar = RainbowNavigationBarView(style: .leftAndRight, title: "작가의 말", subtitle: "에필로그")
    
    private lazy var endButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("1부 마치기", for: .normal)
        $0.setTitleColor(.macoGray, for: .disabled)
        $0.setBackgroundColor(.macoLightGray, for: .disabled)
    }
    
    private lazy var backgroundPageView = UIView().then {
        $0.backgroundColor = .macoIvory
    }
    
    private lazy var  vLineView = UIView().then {
        $0.backgroundColor = .macoBlue
    }
    
    private lazy var hLineView = UIView().then {
        $0.backgroundColor = .macoBlue
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "1부를 마치며"
        $0.font = .macoFont(type: .medium, size: 20)
        $0.textColor = .macoDarkGray
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .macoFont(type: .regular, size: 14)
        $0.textColor = .macoDarkGray
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private lazy var writerSaidLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 17)
        $0.textColor = .macoDarkGray
        $0.text = "작가의 말"
    }
    
    private lazy var textView = UITextView().then {
        $0.setConerRadius(color: .macoBlue)
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 12, bottom: 12, right: 15)
    }
    
    private lazy var textViewUnderLineView = UIView().then {
        $0.backgroundColor = .macoBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initRainbowEpillogeuViewController()
        
        setContentText()
        setRainbowNavigationBar()
        setEndButton()
        setBackgroundPageView()
        setLabels()
        setTextView()
        
    }
    
    private func initRainbowEpillogeuViewController() {
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
    
    private func setEndButton() {
        view.addSubviews(endButton)
        
        endButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
        }
       
    }
    
    private func setBackgroundPageView() {
        view.addSubviews(backgroundPageView, vLineView, hLineView)
        
        backgroundPageView.snp.makeConstraints {
            $0.top.equalTo(rainbowNavigationBar.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(105)
        }
        
        vLineView.snp.makeConstraints {
            $0.top.equalTo(backgroundPageView.snp.top)
            $0.bottom.equalTo(backgroundPageView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(1)
        }
        
        hLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(backgroundPageView.snp.bottom).inset(10)
            $0.height.equalTo(1)
        }
    }
    
    private func setLabels() {
        view.addSubviews(titleLabel, contentLabel, writerSaidLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(36)
            $0.top.equalTo(backgroundPageView.snp.top).offset(28)
            $0.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        writerSaidLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(30)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(17)
        }
    }
    
    private func setTextView() {
       
        textView.delegate = self
        textView.isScrollEnabled = true
        
        setPlaceholder()
        
        view.addSubviews(textView, textViewUnderLineView)

        textView.snp.makeConstraints {
            $0.top.equalTo(writerSaidLabel.snp.bottom).offset(9)
            $0.bottom.equalTo(backgroundPageView.snp.bottom).inset(66)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        textViewUnderLineView.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom)
            $0.leading.equalTo(textView.snp.leading)
            $0.trailing.equalTo(textView.snp.trailing)
            $0.height.equalTo(1)
        }
        
    }
    
    private func setContentText() {
        contentLabel.text = "이별을 마무리하는 마지막 단계예요.\n코봉의 행복한 시간들을 잘 보셨나요?\n작가님과 함께했던 코봉코봉코봉이의 삶이 어땠는지\n적어주세요. 그리고 이제는 작가님의 이야기를\n들려주세요."
        
        contentLabel.setLineSpacing(lineSpacing: 5)
    }
    
}

extension RainbowEpillogeuViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .macoGray {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            setPlaceholder()
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.attributedText = textView.text.attributedString(font: .macoFont(type: .regular, size: 16), color: .macoBlack, customLineHeight: 28)
        if !textView.text.isEmpty {
            endButton.isEnabled = true
        } else {
            endButton.isEnabled = false
        }
    }
    
    func setPlaceholder() {
        textView.text = "코봉이d의 이야기를 들려주세요."
        textView.textColor = .macoGray
        textView.font = .macoFont(type: .regular, size: 14)
        
        endButton.isEnabled = false
    }
}
