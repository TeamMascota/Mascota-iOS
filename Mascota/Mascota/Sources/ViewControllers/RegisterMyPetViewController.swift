//
//  RegisterMyPetViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/04.
//

import UIKit

class RegisterMyPetViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var pageNumberLabel: UILabel!
    
    @IBOutlet weak var registerPetCollectionView: UICollectionView!
    @IBOutlet weak var numberOfDonePetLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var namelengthLabel: UILabel!
    @IBOutlet var underlineView: [UIView]!
    
    @IBOutlet weak var catOrDogStackView: UIStackView!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    
    @IBOutlet weak var becomeFamilyDateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    @IBOutlet var genderButton: [UIButton]!

    var myPetsArray = [PetInfo]()
    var myPetImageArray = [UIImage]()
    
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()
    let picker = UIImagePickerController()
    var datePickerBackgroundView = UIView()
    var currentCellNum = 0
    var isSelected : Bool = true
    
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
        setDatePickerView()
        self.view.addSubview(datePickerBackgroundView)
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        self.view.addSubview(datePicker)
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.onDoneButtonClick))
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelButtonClick))
        let blankSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        cancelButton.tintColor = .macoLightGray
        doneButton.tintColor = .macoOrange
        toolBar.items = [cancelButton, blankSpace, doneButton]
        
        self.view.addSubview(toolBar)
    }
    
    // MARK: - @objc
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        if let date = sender?.date {
            becomeFamilyDateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    @objc func onDoneButtonClick() {
        becomeFamilyDateLabel.font = .macoFont(type: .regular, size: 16.0)
        becomeFamilyDateLabel.textColor = .macoBlack
        calendarButton.imageView?.image = UIImage(named: "icCalendarFill")
        datePickerBackgroundView.removeFromSuperview()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
        underlineView[1].backgroundColor = .macoOrange
    }
    
    @objc func cancelButtonClick() {
        becomeFamilyDateLabel.text = "YYYY.MM.DD"
        becomeFamilyDateLabel.textColor = .macoLightGray
        datePickerBackgroundView.removeFromSuperview()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
          let alert = UIAlertController(title: "프로필 삭제", message: "작성 중이던 주인공 \(String(currentCellNum+1))의 프로필 정보가 \n 모두 사라집니다. 프로필을 삭제하시겠어요? ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제", style: .default, handler: {_ in
            
            if self.currentCellNum == 0 {
                // 주인공 많을 때랑 한개일 때 분기처리해야함!!
                if self.myPetsArray.count == 1 {
                    self.myPetsArray[0] = PetInfo(petImages: UIImage(named: "yeonseo")!, name: "", kind: 0, startDate: "", gender: 0)
                } else {
                    self.myPetsArray.remove(at: 0)
                }
            } else {
                print("==============현재 셀 넘버===========")
                print(self.currentCellNum)
                self.myPetsArray.remove(at: self.currentCellNum)
            }
            self.registerPetCollectionView.reloadData()
        } )
          let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
          alert.addAction(okAction)
          self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - tapImageView
    @objc func tapImageView(tapGestureRecognizer: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in }
        cancelAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        
        let showlibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in  self.openLibrary()    }
        
        showlibraryAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        
        let deleteImageAction = UIAlertAction(title: "사진삭제", style: .default) { _ in self.myPetsArray[self.currentCellNum].petImages = UIImage(named: "yeonseo") ?? UIImage()
            self.registerPetCollectionView.reloadData()
        }
        deleteImageAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        print(myPetsArray[currentCellNum].petImages)
        if myPetsArray[currentCellNum].petImages == UIImage() || myPetsArray[currentCellNum].petImages == UIImage(named: "yeonseo") {
            alertController.addAction(showlibraryAction)
        } else {
            alertController.addAction(showlibraryAction)
            alertController.addAction(deleteImageAction)
        }
        
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        alertController.view.layer.masksToBounds = true
        alertController.view.layer.cornerRadius = 3.0
        
        let attributedString = NSAttributedString(string: "프로필 사진 등록하기", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0) ,
            NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        ])
        alertController.setValue(attributedString, forKey: "attributedMessage")
        
        present(alertController, animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setNavigationBar()
        setButtons()
        setDateLabelPlaceholder()
        appendEmptyElement()
        registerCollectionView()
        registerCollectionViewCell()
    }
    
    func appendEmptyElement() {
        myPetsArray.append(PetInfo(petImages: UIImage(named: "yeonseo") ?? UIImage(), name: "", kind: 0, startDate: "", gender: 0))
    }
     
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        navigationBar.barTintColor = .macoIvory
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        pageNumberLabel.font = .macoFont(type: .medium, size: 15.0)
        pageNumberLabel.textColor = .macoDarkGray
    }
    
    // MARK: - Set DatePicker
    func setDatePickerView() {
        datePicker.backgroundColor = .clear
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        datePickerBackgroundView.backgroundColor = .macoWhite
        datePickerBackgroundView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
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

// MARK: - TextField Delegate
extension RegisterMyPetViewController: UITextFieldDelegate {
    func setTextField() {
        self.nameTextField.delegate = self
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if nameTextField.text!.count == 0 {
            underlineView[0].backgroundColor = .macoLightGray
        } else {
            underlineView[0].backgroundColor = .macoOrange
        }
        namelengthLabel.text = "(" + String(nameTextField.text!.count) + "/6)"
    }
}

// MARK: - CollectionView DataSource, Delegate
extension RegisterMyPetViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPetsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView(tapGestureRecognizer:)))
        
        if indexPath.row == myPetsArray.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakePlusCollectionViewCell", for: indexPath) as? MakePlusCollectionViewCell else {
                return UICollectionViewCell()
            }
            setPlusCell(cell, .macoLightGray, indexPath.row + 1)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterMyPetCollectionViewCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.myPetImage.isUserInteractionEnabled = true
            cell.myPetImage.addGestureRecognizer(tapGestureRecognizer)
            cell.closeButton.tag = indexPath.row
            cell.closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
            setRegisterCell(cell, .macoLightGray, indexPath.row + 1)
            if myPetsArray[indexPath.row].petImages == UIImage() {
                cell.myPetImage.image = UIImage(named: "yeonseo")
            } else {
                cell.myPetImage.image = myPetsArray[indexPath.row].petImages
            }
            return cell
        }
    }
    
    // MARK: - Add CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nameLabel.text = "주인공 " + String(indexPath.row + 1) + "의 이름"
        switch indexPath.row {
        case myPetsArray.count: // 마지막셀
            currentCellNum = indexPath.row
            myPetsArray.append(PetInfo(petImages: UIImage(), name: "", kind: 0, startDate: "", gender: 0))
            registerPetCollectionView.reloadData()
        default:
            currentCellNum = indexPath.row
        }
    }

    // MARK: - Set CollectionViewCell
    func setPlusCell(_ sender: MakePlusCollectionViewCell, _ color: UIColor, _ index: Int) {
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = 4.0
        sender.layer.borderColor = color.cgColor
        sender.characterNumberLabel.text = "주인공 " + String(index)
        sender.characterNumberLabel.backgroundColor = color
        sender.characterNumberLabel.textColor = UIColor.white
    }
    
    func setRegisterCell(_ sender: RegisterMyPetCollectionViewCell, _ color: UIColor, _ index: Int) {
        sender.layer.borderWidth = 0.0
        sender.layer.cornerRadius = 4.0
        sender.layer.borderColor = color.cgColor
        sender.characterNumberLabel.text = "주인공 " + String(index)
        sender.characterNumberLabel.backgroundColor = color
        sender.characterNumberLabel.textColor = UIColor.white
    }
}

extension RegisterMyPetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

// MARK: - ImagePicker
extension RegisterMyPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myPetsArray[currentCellNum].petImages = image
            registerPetCollectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
}
