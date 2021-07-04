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
    @IBOutlet weak var becomeFamilyDateLabel: UILabel!
    var myPetsArray = [RegisterMyPetModel]()
    
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
        setLabelPlaceholder()
        //setRandomData()
    }
    
    func setRandomData() {
        myPetsArray.append(RegisterMyPetModel(petImage: "ee", petName: "ee", petKind: "ff", familyDate: "ggg", petGender: "eee"))
        myPetsArray.append(RegisterMyPetModel(petImage: "ee", petName: "ee", petKind: "ff", familyDate: "ggg", petGender: "eee"))
    }
    
    // MARK: - Functions
    
    func setLabelPlaceholder() {
        becomeFamilyDateLabel.text = "YYYY.MM.DD"
        becomeFamilyDateLabel.textColor = UIColor.macoLightGray
    }
    
    func setCollectionView() {
        registerPetCollectionView.dataSource = self
        registerPetCollectionView.delegate = self
        registerPetCollectionView.register(UINib(nibName: "MakePlusCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MakePlusCollectionViewCell")
        registerPetCollectionView.register(UINib(nibName: "RegisterMyPetCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RegisterMyPetCollectionViewCell")
        
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
        return myPetsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case myPetsArray.count: // 마지막셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakePlusCollectionViewCell", for: indexPath) as? MakePlusCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.macoOrange.cgColor
            cell.characterNumberLabel.backgroundColor = UIColor.macoGray
            cell.characterNumberLabel.textColor = UIColor.white
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterMyPetCollectionViewCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.macoOrange.cgColor
            cell.characterNumberLabel.backgroundColor = UIColor.macoOrange
            cell.characterNumberLabel.textColor = UIColor.white
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == myPetsArray.count {
            print("마지막셀 클릭됨")
        }
    }
}

extension RegisterMyPetViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = Constant.Size.width * (100 / 374)
        let cellHeight = cellWidth * (132 / 100)
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
