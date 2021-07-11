//
//  RegisterPrologBookViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/11.
//

import UIKit

class RegisterPrologBookViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationItem.leftItemsSupplementBackButton = true
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
    
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
}
