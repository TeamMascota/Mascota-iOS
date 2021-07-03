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
    @IBOutlet var lineViewUnderTextield: [UIView]!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var sigunUpButton: UIButton!
    
    // MARK: IBActions
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idEmailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        idEmailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == idEmailTextField {
            if textField.text!.count == 0 {
                lineViewUnderTextield[0].backgroundColor = UIColor.black
            } else {
                lineViewUnderTextield[0].backgroundColor = UIColor.blue}
        } else {
            if textField.text!.count == 0 {
                lineViewUnderTextield[1].backgroundColor = UIColor.black
            } else {
                lineViewUnderTextield[1].backgroundColor = UIColor.green
            }
        }
        
        if !idEmailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = UIColor.red
        } else {
            
            loginButton.backgroundColor = UIColor.blue
        }
    }
    
}

// MARK : - Delegate
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
