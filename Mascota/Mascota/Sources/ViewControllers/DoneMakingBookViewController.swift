//
//  DoneMakingBookViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/13.
//

import UIKit

class DoneMakingBookViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButtton: UIButton!
    @IBOutlet weak var startTextLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bookCoverView: UIView!
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var goToHomeBUtton: UIButton!
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
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
    func setView() {
        bookCoverView.layer.masksToBounds = true
        bookCoverView.layer.cornerRadius = 3.0
        goToHomeBUtton.layer.cornerRadius = 3.0
        startTextLabel.font = .macoFont(type: .regular, size: 20.0)
        bookNameLabel.font = .macoFont(type: .medium, size: 20.0)
        authorNameLabel.font = .macoFont(type: .regular, size: 17.0)
        goToHomeBUtton.titleLabel?.font = .macoFont(type: .medium, size: 20.0)
    }

}
