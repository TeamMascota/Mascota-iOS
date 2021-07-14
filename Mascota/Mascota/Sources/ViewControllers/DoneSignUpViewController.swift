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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        registerPetButtton.layer.cornerRadius = Constant.round3
        registerPetButtton.titleLabel?.font = UIFont.macoFont(type: .medium, size: 20.0)
        textLabel.font = .macoFont(type: .regular, size: 20.0)
    }
}
