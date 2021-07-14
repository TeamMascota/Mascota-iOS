//
//  LoginViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/02.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var idEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet var underlineView: [UIView]!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var sigunUpButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func tapSignUpButton() {
        let vc = UIStoryboard(name: "SignUp", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    
    // MARK: - set Functions
    func setTextField() {
        self.idEmailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        idEmailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if idEmailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1.0)
            loginButton.titleLabel?.textColor = .macoLightGray
        } else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .macoOrange
            loginButton.titleLabel?.textColor = .macoWhite
        }
        
        switch textField {
        case idEmailTextField:
            if textField.text!.count == 0 {
                underlineView[0].backgroundColor = .macoLightGray
            } else {
                underlineView[0].backgroundColor = .macoOrange
            }
        case passwordTextField:
            if textField.text!.count == 0 {
                underlineView[1].backgroundColor = .macoLightGray
            } else {
                underlineView[1].backgroundColor = .macoOrange
            }
        default:
            print("login default!")
        }
    }
    
    func setView() {
        loginButton.layer.cornerRadius = Constant.round3
        loginButton.titleLabel?.font = .macoFont(type: .medium, size: 21.0)
        idLabel.font = .macoFont(type: .medium, size: 15.0)
        passwordLabel.font = .macoFont(type: .medium, size: 15.0)
    }
    
}

// MARK: - Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        if sender == idEmailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
}
