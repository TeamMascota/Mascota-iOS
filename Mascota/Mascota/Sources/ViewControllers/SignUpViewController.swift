//
//  SignUpViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/04.
//

import UIKit
import Moya

class SignUpViewController: BaseViewController {
    // MARK: - Properties
    let service = MoyaProvider<AccountAPI>(plugins: [MoyaLoggingPlugin()])
    
    var signUpResponseModel: ResponseSignUpModel?
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var idEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var iDLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var illustrateImageView: UIImageView!
    
    @IBOutlet var underlineView: [UIView]!
    @IBOutlet var infoLabel: [UILabel]!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var doubleCheckButton: UIButton!
    @IBOutlet var checkImageView: [UIImageView]!
    @IBOutlet var macoimage: UIImageView!
    
    // MARK: - IBActions
    @IBAction func tapSignUpButton() {
        if signUpButton.isEnabled {
            connectServer()
        } else {
            return
        }
    }
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doubleCheckButtonTapped() {
        connectServer()
    }
    
    private func connectServer() {
        self.attachIndicator(.normal)
        service.request(AccountAPI.postSignUp(email: idEmailTextField.text!, password: passwordTextField.text!)) { [weak self] result in
            self?.detachIndicator()
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode(ResponseSignUpModel.self, from: response.data)
                    self.signUpResponseModel = data
                    print("before status")
                    print(self.signUpResponseModel?.status)
                    guard let status = self.signUpResponseModel?.status else {return}
                    if status == 200 {
                        guard let nextVC =  self.storyboard?.instantiateViewController(identifier: "DoneSignUpViewController") as? DoneSignUpViewController else
                                {
                            return }
                        nextVC.idEmail = self.idEmailTextField.text ?? ""
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                    
                    guard let message = self.signUpResponseModel?.message else {
                       return
                    }
                    
                    if self.signUpResponseModel?.success == false {
                        if message == "존재하는 ID 입니다." {
                            self.infoLabel[0].isHidden = false
                            self.infoLabel[0].text = "사용할 수 없는 아이디입니다"
                        } else {
                            
                        }
                    }
                } catch (let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print("통신실패")
                print(error.localizedDescription)
            }
        }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkNotch()
    }
    
    func checkNotch() {
        if UIDevice.current.hasNotch {
            macoimage.isHidden = false
        } else {
            macoimage.isHidden = true
        }
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
        illustrateImageView.image = UIImage(named: "illustLoginsignupSmall")
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
        if !idEmailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !passwordCheckTextField.text!.isEmpty && (passwordTextField.text == passwordCheckTextField.text) {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .macoOrange
            signUpButton.setTitleColor(.white, for: .normal)
            //signUpButton.titleLabel?.textColor = UIColor.white
        } else {
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(.macoLightGray, for: .normal)
            signUpButton.backgroundColor = UIColor(red: 229.0/255.0, green: 228.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        }
        /*
        if idEmailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || passwordCheckTextField.text!.isEmpty {
                signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 229.0/255.0, green: 228.0/255.0, blue: 226.0/255.0, alpha: 1.0)
                //signUpButton.titleLabel?.textColor = .macoLightGray
            } else {
                signUpButton.isEnabled = true
                signUpButton.backgroundColor = .macoOrange
                signUpButton.titleLabel?.textColor = .macoWhite
            }
        */
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
