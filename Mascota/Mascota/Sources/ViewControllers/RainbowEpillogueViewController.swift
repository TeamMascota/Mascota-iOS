//
//  RainbowEpillogueViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

class RainbowEpillogueViewController: UIViewController {
    
    private lazy var rainbowNavigationBar = RainbowNavigationBarView(style: .leftAndRight, title: "작가의 말", subtitle: "에필로그", underLineHidden: true)

    private lazy var bookMarkImageView = UIImageView().then {
        $0.image = .checkmark // 이미지 넣기
        $0.backgroundColor = .blue
    }
    
    private lazy var endButton = MacoButton(color: .blue).then {
        $0.setMacoButtonTitle("이별의 단계 완료", for: .normal)
        $0.setTitleColor(.macoGray, for: .disabled)
        $0.setBackgroundColor(.macoLightGray, for: .disabled)
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .macoFont(type: .regular, size: 14)
        $0.textColor = .macoDarkGray
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private lazy var epilogueTitleLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 17)
        $0.textColor = .macoDarkGray
        $0.text = "에필로그 제목"
    }
    
    private lazy var epilogueTitleTextField = UITextField().then {
        $0.addDoneButtonOnKeyboard(color: .macoBlue)
    }
    
    private lazy var epilogueLabel = UILabel().then {
        $0.font = .macoFont(type: .medium, size: 17)
        $0.textColor = .macoDarkGray
        $0.text = "에필로그"
    }
    
    private lazy var textView = UITextView().then {
        $0.setMacoTextView(color: .macoBlue)
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 12, bottom: 10, right: 12)
        $0.addDoneButtonOnKeyboard(color: .macoBlue)
    }
    
    private lazy var continueLabel = UILabel().then {
        let continueAttr = NSMutableAttributedString()
        continueAttr.append("2부".convertColorFont(color: .macoDarkGray, fontSize: 14, type: .medium))
        continueAttr.append("에서 계속".convertColorFont(color: .macoDarkGray, fontSize: 14, type: .regular))

        $0.attributedText = continueAttr
    }
    
    private lazy var backButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(tapBackButton(_ :)))
    private lazy var closeButton = UIBarButtonItem(image: .actions, style: .plain, target: self, action: #selector(tapCloseButton(_ :)))
    
    private lazy var name: String = "가나다라마바사"
    
    private lazy var keyboardHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initRainbowEpillogeuViewController()
        
        setPetName()
        
        setContentText()
        setEndButton()
        setLabels()
        setTitleTextField()
        setTextView()
        
        setRainbowNavigationBar()
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setUnderLine(color: .macoBlue)
        epilogueTitleTextField.setMacoTextField(color: .macoBlue)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initRainbowEpillogeuViewController() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        view.backgroundColor = .macoIvory
       
        view.addSubviews(bookMarkImageView)
        
        bookMarkImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(30)
            $0.height.equalTo(85)
        }
        
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.navigationBar.barTintColor = .macoBlue
        navigationController?.navigationBar.tintColor = .macoWhite
        navigationItem.setTitle(title: "작가의 말", subtitle: "에필로그")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
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
    
    private func setLabels() {
        view.addSubviews(contentLabel, epilogueLabel)
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(43)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(28)
        }
        
    }
    
    private func setTitleTextField () {
        epilogueTitleTextField.delegate = self
        
        epilogueTitleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        view.addSubviews(epilogueTitleLabel, epilogueTitleTextField)
        
        epilogueTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(51)
            $0.leading.equalTo(contentLabel.snp.leading)
            $0.height.equalTo(17)
        }

        epilogueTitleTextField.snp.makeConstraints {
            $0.top.equalTo(epilogueTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(contentLabel.snp.leading)
            $0.trailing.equalTo(contentLabel.snp.trailing)
            $0.height.equalTo(40)
        }
    }
    
    private func setTextView() {
       
        textView.delegate = self
        textView.isScrollEnabled = true
        
        setPlaceholder()
        
        view.addSubviews(epilogueLabel, textView, continueLabel)
        
        epilogueLabel.snp.makeConstraints {
            $0.top.equalTo(epilogueTitleTextField.snp.bottom).offset(28)
            $0.leading.equalTo(contentLabel.snp.leading)
            $0.height.equalTo(17)
        }

        textView.snp.makeConstraints {
            $0.top.equalTo(epilogueLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(142)
            $0.leading.equalTo(contentLabel.snp.leading)
            $0.trailing.equalTo(contentLabel.snp.trailing)
        }
        
        continueLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(8)
            $0.trailing.equalTo(contentLabel.snp.trailing)
        }
        
    }
    
    private func setContentText() {
        contentLabel.text = "이별을 마무리하는 마지막 단계예요.\n\(name)의 행복한 시간들을 잘 보셨나요?\n작가님과 함께했던 코봉코봉코봉이의 삶이 어땠는지\n적어주세요. 그리고 이제는 작가님의 이야기를\n들려주세요."
        contentLabel.setLineSpacing(lineHeight: 20)
    }
    
    private func setPetName() {
        name = "뮨서"
    }
    
}

extension RainbowEpillogueViewController: UITextFieldDelegate {
    
}

extension RainbowEpillogueViewController {
    @objc
    func tapBackButton(_ sender: UIBarButtonItem) {
        print("click")
    }
    
    @objc
    func tapCloseButton(_ sender: UIBarButtonItem) {
        print("click")
    }
}

extension RainbowEpillogueViewController {
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        endButton.isEnabled = checkEndButtonEnabled()
    }
    
    func checkEndButtonEnabled() -> Bool {
        guard let text = epilogueTitleTextField.text else { return false }
        
        if text.isEmpty || textView.text == "\(name)의 이야기를 마무리하는 글을 적어주세요." {
            return false
        } else {
            return true
        }
        
    }
}

extension RainbowEpillogueViewController {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
}

extension RainbowEpillogueViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .macoGray {
            textView.text = nil
        }
        
        if UIDevice.current.hasNotch {
            animateViewMoving(position: keyboardHeight - 80 - view.safeAreaInsets.bottom, upward: true)
        } else {
            animateViewMoving(position: keyboardHeight - 80, upward: true)
        }

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceholder()
        }
        
        animateViewMoving(position: 0, upward: false)

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.attributedText = textView.text.attributedString(font: .macoFont(type: .regular, size: 16), color: .macoBlack, customLineHeight: 28)
        endButton.isEnabled = checkEndButtonEnabled()
        
    }
    
    func setPlaceholder() {
        textView.text = "\(name)의 이야기를 마무리하는 글을 적어주세요."
        textView.textColor = .macoGray
        textView.font = .macoFont(type: .regular, size: 14)
        
        endButton.isEnabled = checkEndButtonEnabled()
    }
    
}

extension RainbowEpillogueViewController {
    func animateViewMoving(position: CGFloat, upward: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut) {
            self.view.frame.origin.y = -position
        }

    }
}
