//
//  RegisterPrologBookViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/11.
//

import UIKit

class RegisterPrologBookViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var bookCoverView: UIView!
    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var numberOfRegisteredPetLabel: UILabel!
    
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var bookNamelengthLabel: UILabel!
    @IBOutlet var underlineView: [UIView]!
    
    @IBOutlet weak var authorNameTextField: UITextField!
    @IBOutlet weak var authorNamelengthLabel: UILabel!
    
    @IBOutlet weak var prologNameTextField: UITextField!
    @IBOutlet weak var prologNamelengthLabel: UILabel!
    
    @IBOutlet weak var prologTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    var filledIn: [Bool] = [false, false, false, false]
    let picker = UIImagePickerController()
    var totalpet = ""
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
 
    private func enableNextButton() {
        for i in 0...3 {
            if filledIn[i] == false {
                disableNextButton()
                return
            }
        }
        nextButton.backgroundColor = .macoOrange
        nextButton.setTitleColor(.macoWhite, for: .normal)
        nextButton.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(tapGestureRecognizer:)))
        bookCoverImage.isUserInteractionEnabled = true
        bookCoverImage.addGestureRecognizer(tapGestureRecognizer)
        setTextField()
        setTextViewplaceholder()
        setNavigationBar()
        setNumberOfDoneLabel()
        disableNextButton()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func nextButtonTapped() {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "DoneMakingBookViewController") as? DoneMakingBookViewController
        nextVC?.bookName = bookNameTextField.text ?? "제목"
        nextVC?.authorName = authorNameTextField.text ?? "작가"
        nextVC?.prologBookCover = bookCoverImage.image ?? UIImage(named: "btnImgAddBookEmpty")!
        nextVC?.totalPet = self.totalpet
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    func setNavigationBar() {
        navigationBar.barTintColor = .macoIvory
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        pageNumberLabel.font = .macoFont(type: .medium, size: 15.0)
        pageNumberLabel.textColor = .macoDarkGray
    }
    
    func disableNextButton() {
        nextButton.backgroundColor = UIColor(red: 229.0/255.0, green: 228/255, blue: 226/255, alpha: 1.0)
        nextButton.setTitleColor(.macoLightGray, for: .normal)
        nextButton.isEnabled = false
    }
    
    func setUI() {
        bookCoverImage.image = UIImage(named: "btnImgAddBookEmpty")
        bookCoverView.layer.masksToBounds = true
        bookCoverView.layer.cornerRadius = 3.0
        bookCoverView.layer.borderWidth = 1.0
        bookCoverView.layer.borderColor = UIColor.macoOrange.cgColor
    }
    
    @objc func tapImageView(tapGestureRecognizer: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in }
        cancelAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        
        let showlibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in  self.openLibrary()
        }
        
        showlibraryAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        
        let deleteImageAction = UIAlertAction(title: "사진삭제", style: .default) { _ in
            self.bookCoverImage.image = UIImage(named: "btnImgAddBookEmpty") ?? UIImage()
        }
        deleteImageAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        
        if bookCoverImage.image == UIImage(named: "btnImgAddBookEmpty") {
            alertController.addAction(showlibraryAction)
        } else {
            alertController.addAction(showlibraryAction)
            alertController.addAction(deleteImageAction)
        }
        
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        alertController.view.layer.masksToBounds = true
        alertController.view.layer.cornerRadius = 3.0
        
        let attributedString = NSAttributedString(string: "프로필 사진 등록하기", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0) ,
            NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        ])
        alertController.setValue(attributedString, forKey: "attributedMessage")
        
        present(alertController, animated: true)
    }
    
    func setNumberOfDoneLabel() {
        numberOfRegisteredPetLabel.textColor = .macoGray
        numberOfRegisteredPetLabel.attributedText = "현재 작성 완료된 반려동물 주인공 \(totalpet)마리".convertSomeColorFont(color: .macoOrange, fontSize: 20, type: .regular, start: 19, length: 1)
        numberOfRegisteredPetLabel.font = .macoFont(type: .regular, size: 14.0)
    }
}

// MARK: - TextView Delegate
extension RegisterPrologBookViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewShouldEndEditing(_ textiew: UITextView) -> Bool {
        enableNextButton()
        return true
    }
    
    func setTextViewplaceholder() {
         prologTextView.delegate = self
         prologTextView.text = " Q.지금까지 코봉이는 어떤 삶을 살았나요?"
         prologTextView.textColor = UIColor.macoLightGray
     }
    
     // TextView Place Holder
     func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == " Q.지금까지 코봉이는 어떤 삶을 살았나요?" {
            textView.text = ""
            textView.textColor = UIColor.macoBlack
        }
     }
        
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count != 0 {
            filledIn[3] = true
            underlineView[3].backgroundColor = .macoOrange
        } else {
            filledIn[3] = false
            underlineView[3].backgroundColor = .macoLightGray
            disableNextButton()
        }
    }

     // TextView Place Holder
     func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text == "" {
             textView.text = " Q.지금까지 코봉이는 어떤 삶을 살았나요?"
             textView.textColor = UIColor.macoLightGray
             underlineView[3].backgroundColor = .macoLightGray
            filledIn[3] = false
             disableNextButton()
         } else {
            filledIn[3] = true
             underlineView[3].backgroundColor = .macoOrange
         }
     }
}

// MARK: - TextField Delegate
extension RegisterPrologBookViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.enableNextButton()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setTextField() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.bookNameTextField.delegate = self
        self.authorNameTextField.delegate = self
        self.prologNameTextField.delegate = self
        
        bookNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        authorNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        prologNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
         self.view.frame.origin.y = -250
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case bookNameTextField:
            if bookNameTextField.text?.count == 0 {
                filledIn[0] = false
                underlineView[0].backgroundColor = .macoLightGray
                disableNextButton()
            } else {
            filledIn[0] = true
            underlineView[0].backgroundColor = .macoOrange
            }
            bookNamelengthLabel.text = "(" + String(textField.text!.count) + "/12)"
        case authorNameTextField:
            if textField.text?.count == 0 {
                filledIn[1] = false
                underlineView[1].backgroundColor = .macoLightGray
                disableNextButton()
            } else {
                filledIn[1] = true
                underlineView[1].backgroundColor = .macoOrange
            }
            authorNamelengthLabel.text = "(" + String(textField.text!.count) + "/6)"
        case prologNameTextField:
            if textField.text?.count == 0 {
                filledIn[2] = false
                underlineView[2].backgroundColor = .macoLightGray
                disableNextButton()
            } else {
                filledIn[2] = true
                underlineView[2].backgroundColor = .macoOrange
            }
             prologNamelengthLabel.text = "(" + String(textField.text!.count) + "/10)"
        default:
            print("default")
        }
    }
}

// MARK: - ImagePicker
extension RegisterPrologBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            bookCoverImage.image = image
            setBlurToImage()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func setBlurToImage() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.alpha = 0.1
        blurredEffectView.frame = bookCoverImage.bounds
        bookCoverImage.addSubview(blurredEffectView)
    }
}
