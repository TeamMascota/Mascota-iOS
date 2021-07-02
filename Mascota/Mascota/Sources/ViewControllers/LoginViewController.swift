//
//  LoginViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/02.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var idEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lineViewUnderTextield: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var sigunUpButton: UIButton!

    // MARK:- IBActions

    @IBAction func changeViewColor(_ sender: UITextField) {
        if !idEmailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.backgroundColor =  UIColor(red: 230.0/255.0, green: 120.0/255.0, blue: 40.0/255.0, alpha: 1)
        }
    }
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sigunUpButton.backgroundColor = UIColor.macoYellow
        
        self.idEmailTextField.delegate = self
        self.passwordTextField.delegate = self
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
