//
//  DoneSignUpViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/13.
//

import UIKit

class DoneSignUpViewController: UIViewController {

    @IBOutlet weak var registerPetButtton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    var idEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(idEmail)
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
    
    func setView() {
        textLabel.attributedText = "\(idEmail) 님\n회원가입이 완료되었습니다.\n\n작가님, 이제 책을 만들기 위한\n간단한 정보를 등록해 볼까요?".convertSomeColorFont(color: .macoOrange, fontSize: 20, type: .regular, start: 0, length: idEmail.count)
        registerPetButtton.layer.cornerRadius = Constant.round3
        registerPetButtton.titleLabel?.font = UIFont.macoFont(type: .medium, size: 20.0)
        textLabel.font = .macoFont(type: .regular, size: 20.0)
    }
}
