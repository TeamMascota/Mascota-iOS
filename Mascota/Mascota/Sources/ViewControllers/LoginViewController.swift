//
//  LoginViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/02.
//

import UIKit
import Moya

class LoginViewController: UIViewController {
    
    let service = MoyaProvider<AccountAPI>(plugins: [MoyaLoggingPlugin()])
    var loginResponseModel: ResponseLoginModel?
    let customLabelAlertView = CustomLabelAlertView()
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
    
    @IBAction func tapLoginButton() {
        connectServer()
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
            loginButton.setTitleColor(.macoLightGray, for:  .normal)
        } else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .macoOrange
            loginButton.setTitleColor(.macoWhite, for: .normal)
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
    
    func setAlertView() {
        self.customLabelAlertView.setTitle(text: "로그인 실패")
        let description = "아이디 또는 비밀번호가 일치하지 않습니다.\n다시 로그인 해 주세요.".convertSomeColorFont(color: UIColor.macoBlack,fontSize: 14, type: .medium, start: 19, length: 5)
        self.customLabelAlertView.setAttributedDescription(attributedText: description)
        self.presentSingleCustomAlert(view: customLabelAlertView, preferredSize: CGSize(width: 270, height: 130), confirmHandler: nil, text: "확인", color: .macoOrange)
    }
    
    private func connectServer() {
        service.request(AccountAPI.postLogin(email: idEmailTextField.text!, password: passwordTextField.text!)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(ResponseLoginModel.self, from: response.data)
                    self.loginResponseModel = data

                    guard let status = self.loginResponseModel?.status else {return}
                    
                    if status == 200 {
                        print("로그인성공")
                        print(data.data?.userId ?? 0)
                    } else {
                        print("로그인실패")
                        self.setAlertView()
                    }
                } catch (let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
