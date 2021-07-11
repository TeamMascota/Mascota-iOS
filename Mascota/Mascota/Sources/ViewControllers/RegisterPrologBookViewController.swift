//
//  RegisterPrologBookViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/11.
//

import UIKit

class RegisterPrologBookViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var bookCoverView: UIView!
    @IBOutlet weak var numberOfRegisteredPetLabel: UILabel!
    
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var bookNamelengthLabel: UILabel!
    @IBOutlet var underlineView: [UIView]!
    
    @IBOutlet weak var authorNameTextField: UITextField!
    @IBOutlet weak var authorNamelengthLabel: UILabel!
    
    @IBOutlet weak var prologNameTextField: UITextField!
    @IBOutlet weak var prologNamelengthLabel: UILabel!
    
    @IBOutlet weak var prologTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setTextViewplaceholder()
        setNavigationBar()
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
    
    func setNavigationBar() {
       // navigationController?.setMacoNavigationBar(barTintColor: .macoIvory, tintColor: .macoBlack, underLineColor: .macoOrange)
        //navigationItem.setTitle(title: "주인공 등록")
            //navigationItem.leftBarButtonItem = backButton
            //navigationItem.rightBarButtonItem = closeButton
        navigationBar.barTintColor = .macoIvory
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        //pageNumberLabel.font = .macoFont(type: .medium, size: 15.0)
        //pageNumberLabel.textColor = .macoDarkGray
    }
    
    func setUI() {
        bookCoverView.layer.cornerRadius = 3.0
        bookCoverView.layer.borderWidth = 1.0
        bookCoverView.layer.borderColor = UIColor.macoOrange.cgColor
    }
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextView Delegate
extension RegisterPrologBookViewController: UITextViewDelegate {
    
    func setTextViewplaceholder() {
         prologTextView.delegate = self // txtvReview가 유저가 선언한 outlet
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
        if textView.text != "" {
            underlineView[3].backgroundColor = .macoOrange
        } else {
            underlineView[3].backgroundColor = .macoLightGray
        }
    }

     // TextView Place Holder
     func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text == "" {
             textView.text = " Q.지금까지 코봉이는 어떤 삶을 살았나요?"
             textView.textColor = UIColor.macoLightGray
             underlineView[3].backgroundColor = .macoLightGray
         } else {
             underlineView[3].backgroundColor = .macoOrange
         }
     }
}

// MARK: - TextField Delegate
extension RegisterPrologBookViewController: UITextFieldDelegate {
    func setTextField() {
        self.bookNameTextField.delegate = self
        self.authorNameTextField.delegate = self
        self.prologNameTextField.delegate = self
        
        bookNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        authorNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        prologNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case bookNameTextField:
            if bookNameTextField.text!.count == 0 {
                underlineView[0].backgroundColor = .macoLightGray
            } else {
                underlineView[0].backgroundColor = .macoOrange
            }
            bookNamelengthLabel.text = "(" + String(textField.text!.count) + "/12)"
        case authorNameTextField:
            if textField.text!.count == 0 {
                underlineView[1].backgroundColor = .macoLightGray
            } else {
                underlineView[1].backgroundColor = .macoOrange
            }
            authorNamelengthLabel.text = "(" + String(textField.text!.count) + "/6)"
        case prologNameTextField:
            if textField.text!.count == 0 {
                underlineView[2].backgroundColor = .macoLightGray
            } else {
                underlineView[2].backgroundColor = .macoOrange
            }
             prologNamelengthLabel.text = "(" + String(textField.text!.count) + "/10)"
        default:
            print("default")
        }
    }
}
