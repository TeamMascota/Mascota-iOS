//
//  RegisterMyPetViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/04.
//

import UIKit

class RegisterMyPetViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var registerPetCollectionView: UICollectionView!
    @IBOutlet weak var catOrDogStackView: UIStackView!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet var genderButton: [UIButton]!
    
    // MARK: - IBActions
    @IBAction func clickCatOrDogButton(_ sender: UIButton) {
        switch sender {
        case catButton:
            print("cat")
        case dogButton:
            print("dog")
        case genderButton[0]:
            print("boy")
        case genderButton[1]:
            print("girl")
        case genderButton[2]:
            print("secret")
        default:
            print("default")
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setButtons()
    }
    
    // MARK: - Functions
    func setCollectionView() {
        registerPetCollectionView.dataSource = self
        registerPetCollectionView.delegate = self
        registerPetCollectionView.backgroundColor = UIColor.macoIvory
    }
    
    func setButtons() {
        dogButton.layer.borderWidth = 1.0
        dogButton.layer.borderColor = UIColor.macoOrange.cgColor
        dogButton.layer.cornerRadius = 3.0
        
        catButton.layer.borderWidth = 1.0
        catButton.layer.borderColor = UIColor.macoOrange.cgColor
        catButton.layer.cornerRadius = 3.0
        
        genderButton[0].layer.borderWidth = 1.0
        genderButton[0].layer.borderColor = UIColor.macoOrange.cgColor
        genderButton[0].layer.cornerRadius = 3.0
        
        genderButton[1].layer.borderWidth = 1.0
        genderButton[1].layer.borderColor = UIColor.macoOrange.cgColor
        genderButton[1].layer.cornerRadius = 3.0
        
        genderButton[2].layer.borderWidth = 1.0
        genderButton[2].layer.borderColor = UIColor.macoOrange.cgColor
        genderButton[2].layer.cornerRadius = 3.0
    }
}

// MARK: - CollectionView
extension RegisterMyPetViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "registerMyPetCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.borderWidth = 1.0
        
        switch indexPath.row {
        case 0:
            cell.layer.borderColor = UIColor.macoOrange.cgColor
            cell.characterNumberLabel.backgroundColor = UIColor.macoOrange
            cell.characterNumberLabel.textColor = UIColor.white
        default:
            cell.layer.borderColor = UIColor.macoLightGray.cgColor
            cell.characterNumberLabel.backgroundColor = UIColor.macoLightGray
            cell.characterNumberLabel.textColor = UIColor.white
        }
        return cell
    }
    
}

extension RegisterMyPetViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        let cellWidth = width * (100 / 374)
        let cellHeight = cellWidth * (132 / 100)
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
