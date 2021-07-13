//
//  SignUpViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/04.
//

import UIKit

class SignUpViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var idEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var iDLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    
    @IBOutlet var underlineView: [UIView]!
    @IBOutlet var infoLabel: [UILabel]!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var doubleCheckButton: UIButton!
    @IBOutlet var checkImageView: [UIImageView]!
    
    // MARK: - IBActions
    @IBAction func tapSignUpButton() {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "DoneSignUpViewController")
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doubleCheckButtonTapped() {
        //아이디 중복체크
        
        // 중복확인 후 되면 infolabel x
        
        // 안되면 infolabel d
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTextField()
        infoLabelHidden()
        setView()
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
        navigationBar.barTintColor = .macoIvory
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
    
    func infoLabelHidden() {
        infoLabel[0].isHidden = true
        infoLabel[1].isHidden = true
        infoLabel[2].isHidden = true
        checkImageView[0].isHidden = true
        checkImageView[1].isHidden = true
    }
    
    func setView() {
        signUpButton.backgroundColor = UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1.0)
        signUpButton.layer.cornerRadius = Constant.round3
        signUpButton.titleLabel?.font = .macoFont(type: .medium, size: 20.0)
        iDLabel.font = .macoFont(type: .medium, size: 15)
        passwordLabel.font = .macoFont(type: .medium, size: 15)
        passwordCheckLabel.font = .macoFont(type: .medium, size: 15)
        welcomeTextLabel.font = .macoFont(type: .regular, size: 21.0)
    }

}

// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    func setTextField() {
        self.idEmailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordCheckTextField.delegate = self
        
        idEmailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idEmailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || passwordCheckTextField.text!.isEmpty {
                signUpButton.isEnabled = false
                signUpButton.backgroundColor = UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1.0)
                signUpButton.titleLabel?.textColor = .macoLightGray
            } else {
                signUpButton.isEnabled = true
                signUpButton.backgroundColor = .macoOrange
                signUpButton.titleLabel?.textColor = .macoWhite
            }
        
        switch textField {
        case idEmailTextField:
            if idEmailTextField.text!.count == 0 {
                underlineView[0].backgroundColor = .macoLightGray
                infoLabel[0].isHidden = true
            } else {
                underlineView[0].backgroundColor = .macoOrange
            }
        case passwordTextField:
            if passwordTextField.text!.count == 0 {
                underlineView[1].backgroundColor = .macoLightGray
                infoLabel[1].isHidden = true
                checkImageView[0].isHidden = true
            } else {
                underlineView[1].backgroundColor = .macoOrange
                if passwordTextField.text!.count < 8 {
                    infoLabel[1].isHidden = false
                    infoLabel[1].text = "비밀번호는 8자 이상이어야 합니다"
                    checkImageView[0].isHidden = true
                    
                } else {
                    infoLabel[1].isHidden = true
                    checkImageView[0].isHidden = false
                }
            }
        case passwordCheckTextField:
            if passwordCheckTextField.text!.count == 0 {
                underlineView[2].backgroundColor = .macoLightGray
                infoLabel[2].isHidden = true
                checkImageView[1].isHidden = true
            } else {
                underlineView[2].backgroundColor = .macoOrange
                if  passwordTextField.text == passwordCheckTextField.text{
                    infoLabel[2].isHidden = true
                    checkImageView[1].isHidden = false
                } else {
                    infoLabel[2].isHidden = false
                    infoLabel[2].text = "비밀번호가 일치하지 않습니다"
                    checkImageView[1].isHidden = true
                    
                }
            }
        default:
            print("defualt!!")
        }
    }
}
