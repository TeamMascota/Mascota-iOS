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
    @IBOutlet weak var numberOfPetLabel: UILabel!
    
    var bookName = ""
    var authorName = ""
    var prologBookCover = UIImage()
    var totalPet = ""
    
    @IBAction func backButtonTapped(_ sender:UIBarButtonItem!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setLabelText()
        setNumberOfDoneLabel()
        setBlurToImage()
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
    
    func setLabelText() {
        bookNameLabel.text = bookName
        authorNameLabel.text = authorName
        bookCoverImageView.image = prologBookCover
    }
    
    func setNumberOfDoneLabel() {
        numberOfPetLabel.textColor = .macoGray
        numberOfPetLabel.attributedText = "주인공 \(totalPet)마리를 위한 이야기를\n이제 시작해 보세요!".convertSomeColorFont(color: .macoOrange, fontSize: 20, type: .regular, start: 4, length: 1)
        numberOfPetLabel.font = .macoFont(type: .regular, size: 20.0)
    }
    
    func setBlurToImage() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.alpha = 0.1
        blurredEffectView.frame = bookCoverImageView.bounds
        bookCoverImageView.addSubview(blurredEffectView)
    }

}
