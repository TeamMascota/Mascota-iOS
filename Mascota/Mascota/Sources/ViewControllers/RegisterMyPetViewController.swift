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
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    
    // MARK: - IBActions
    @IBAction func clickCatOrDogButton(_ sender: UIButton) {
        switch sender {
        case catButton:
            dogButton.isSelected = false
            setSelectedButton(sender)
            
        case dogButton:
            catButton.isSelected = false
            setSelectedButton(sender)
            
        case genderButton[0]:
            genderButton[1].isSelected = false
            genderButton[2].isSelected = false
            setSelectedButton(sender)
            
        case genderButton[1]:
            genderButton[0].isSelected = false
            genderButton[2].isSelected = false
            setSelectedButton(sender)
            
        case genderButton[2]:
            genderButton[0].isSelected = false
            genderButton[1].isSelected = false
            setSelectedButton(sender)
            
        default:
            print("default")
        }
    }
    
    @IBAction func showDatePicker() {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        //toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }

        @objc func dateChanged(_ sender: UIDatePicker?) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
                
            if let date = sender?.date {
                print("Picked the date \(dateFormatter.string(from: date))")
                becomeFamilyDateLabel.text = dateFormatter.string(from: date)
            }
        }

        @objc func onDoneButtonClick() {
            toolBar.removeFromSuperview()
            datePicker.removeFromSuperview()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        setDateLabelPlaceholder()
        appendEmptyElement()
        registerCollectionView()
        registerCollectionViewCell()
    }
    
    func appendEmptyElement() {
        myPetsArray.append(RegisterMyPetModel(petImage: "", petName: "", petKind: "", familyDate: "", petGender: ""))
    }
    
    // MARK: - Register CollectionView
    func registerCollectionView() {
        registerPetCollectionView.dataSource = self
        registerPetCollectionView.delegate = self
        registerPetCollectionView.backgroundColor = UIColor.macoIvory
    }
    
    func registerCollectionViewCell() {
        registerPetCollectionView.register(UINib(nibName: "MakePlusCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MakePlusCollectionViewCell")
        registerPetCollectionView.register(UINib(nibName: "RegisterMyPetCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RegisterMyPetCollectionViewCell")
        
    }
    
    // MARK: - Set Buttons
    func setSelectedButton(_ sender: UIButton) {
        sender.isSelected = true
        sender.setTitleColor(.macoWhite, for: .selected)
        sender.setBackgroundColor(.macoOrange, for: .selected)
        sender.layer.cornerRadius = 3.0
    }
    
    func setButtons() {
        setButtonView(dogButton, color: .macoOrange)
        setButtonView(catButton, color: .macoOrange)
        setButtonView(genderButton[0], color: .macoOrange)
        setButtonView(genderButton[1], color: .macoOrange)
        setButtonView(genderButton[2], color: .macoOrange)
    }
    
    func setButtonView(_ sender: UIButton, color: UIColor) {
        sender.layer.borderWidth = 1.0
        sender.layer.borderColor = color.cgColor
        sender.layer.cornerRadius = 3.0
    }
    
    func setDateLabelPlaceholder() {
        becomeFamilyDateLabel.text = "YYYY.MM.DD"
        becomeFamilyDateLabel.textColor = UIColor.macoLightGray
    }

}

// MARK: - CollectionView
extension RegisterMyPetViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPetsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterMyPetCollectionViewCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
                return UICollectionViewCell()
            }
            setRegisterCell(cell,.macoOrange, 1)
            return cell
        case myPetsArray.count: // 마지막셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakePlusCollectionViewCell", for: indexPath) as? MakePlusCollectionViewCell else {
                return UICollectionViewCell()
            }
            setPlusCell(cell, .macoLightGray , myPetsArray.count + 1)
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterMyPetCollectionViewCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
                return UICollectionViewCell()
            }
            setRegisterCell(cell, .macoOrange,indexPath.row + 1)
            return cell
        }
        
    }
    
    // MARK: - Add CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == myPetsArray.count {
            myPetsArray.append(RegisterMyPetModel(petImage: "", petName: "", petKind: "", familyDate: "", petGender: ""))
        }
        registerPetCollectionView.reloadData()
    }
    
    // MARK: - Set CollectionViewCell
    func setPlusCell(_ sender: MakePlusCollectionViewCell,_ color: UIColor,_ index: Int) {
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = 3.0
        sender.layer.borderColor = color.cgColor
        sender.characterNumberLabel.text = "주인공 " + String(index)
        sender.characterNumberLabel.backgroundColor = color
        sender.characterNumberLabel.textColor = UIColor.white
    }
    
    func setRegisterCell(_ sender: RegisterMyPetCollectionViewCell,_ color: UIColor,_ index: Int) {
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = 3.0
        sender.layer.borderColor = color.cgColor
        sender.characterNumberLabel.text = "주인공 " + String(index)
        sender.characterNumberLabel.backgroundColor = color
        sender.characterNumberLabel.textColor = UIColor.white
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
