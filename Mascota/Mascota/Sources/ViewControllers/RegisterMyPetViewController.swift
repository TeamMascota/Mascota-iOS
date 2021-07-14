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
    
    // MARK: - IBActions
    @IBAction func clickCatOrDogButton(_ sender: UIButton) {
        switch sender {
        case catButton:
            dogButton.isSelected = false
            setSelectedButton(sender)
            myPetsArray[currentCellNum].kind = 2
        case dogButton:
            catButton.isSelected = false
            setSelectedButton(sender)
            myPetsArray[currentCellNum].kind = 1
            
        case genderButton[0]:
            genderButton[1].isSelected = false
            genderButton[2].isSelected = false
            setSelectedButton(sender)
            myPetsArray[currentCellNum].gender = 0
            
        case genderButton[1]:
            genderButton[0].isSelected = false
            genderButton[2].isSelected = false
            setSelectedButton(sender)
            myPetsArray[currentCellNum].gender = 1
            
        case genderButton[2]:
            genderButton[0].isSelected = false
            genderButton[1].isSelected = false
            setSelectedButton(sender)
            myPetsArray[currentCellNum].gender = 2
        default:
            print("default")
        }
    }
    
    @IBAction func nextButtonTapped() {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterPrologBookViewController")
        self.navigationController?.pushViewController(nextVC!, animated: true)
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
            myPetsArray[currentCellNum].startDate = becomeFamilyDateLabel.text ?? ""
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
        // 주인공 많을 때랑 한개일 때 분기처리해야함!!
        print(sender.tag)
        print(currentCellNum)
        let alert = UIAlertController(title: "프로필 삭제", message: "작성 중이던 주인공 \(String(sender.tag + 1))의 프로필 정보가 \n 모두 사라집니다. 프로필을 삭제하시겠어요? ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제", style: .default, handler: {_ in
            if self.currentCellNum == 0 { //첫번짺꺼 눌렀을 때
                if self.myPetsArray.count == 1 {
                    self.myPetsArray[0] = PetInfo(petImages: UIImage(named: "yeonseo")!, name: nil, kind: nil, startDate: nil, gender: nil)
                } else { //여러개일때
                    self.myPetsArray.remove(at: 0)
                    
                }
            } else { //2번째 이상 눌렀을 때
                self.myPetsArray.remove(at: sender.tag)
            }
            self.nameLabel.text = "주인공 \(String(sender.tag+1))의 이름"
            self.registerPetCollectionView.reloadData()
        })
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
        
        let showlibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in  self.openLibrary()
            
        }
        
        showlibraryAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        
        let deleteImageAction = UIAlertAction(title: "사진삭제", style: .default) { _ in self.myPetsArray[self.currentCellNum].petImages = UIImage(named: "yeonseo") ?? UIImage()
            
            self.registerPetCollectionView.reloadData()
        }
        deleteImageAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor")
        
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
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0) ,
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
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.isNavigationBarHidden = true
       }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.isNavigationBarHidden = false
       }
    
    func appendEmptyElement() {
        myPetsArray.append(PetInfo(petImages: UIImage(named: "yeonseo") ?? UIImage(), name: nil, kind: nil, startDate: nil, gender: nil))
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
        sender.layer.masksToBounds = true
        sender.layer.cornerRadius = Constant.round3
        sender.isSelected = true
        sender.setTitleColor(.macoWhite, for: .selected)
        sender.setBackgroundColor(.macoOrange, for: .selected)
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
    
    func resetComponents() {
        underlineView[0].backgroundColor = .lightGray
        underlineView[1].backgroundColor = .lightGray
        nameTextField.text = ""
        namelengthLabel.text = "(0/6)"
        catButton.isSelected = false
        dogButton.isSelected = false
        genderButton[0].isSelected = false
        genderButton[1].isSelected = false
        genderButton[2].isSelected = false
        catButton.setBackgroundColor(.macoWhite, for: .normal)
        dogButton.setBackgroundColor(.macoWhite, for: .normal)
        setDateLabelPlaceholder()
        calendarButton.imageView?.image = UIImage(named: "icCalendarEmpty")
        genderButton[0].setBackgroundColor(.macoWhite, for: .normal)
        genderButton[1].setBackgroundColor(.macoWhite, for: .normal)
        genderButton[2].setBackgroundColor(.macoWhite, for: .normal)
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
        myPetsArray[currentCellNum].name = nameTextField.text ?? ""
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
            if indexPath.item == myPetsArray.count - 1 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                cell.isSelected = true
                print(indexPath.item)
            }
            
            cell.myPetImage.isUserInteractionEnabled = true
            cell.myPetImage.tag = indexPath.row
            cell.myPetImage.addGestureRecognizer(tapGestureRecognizer)
   
            cell.closeButton.tag = indexPath.row
            cell.closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
            
            cell.setPetName(name: "주인공 \(indexPath.item + 1)")
            
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
            resetComponents()
            myPetsArray.append(PetInfo(petImages: UIImage(), name: nil, kind: nil, startDate: nil, gender: nil))
            registerPetCollectionView.reloadData()
        default:
            currentCellNum = indexPath.row
            resetComponents()
            if nameTextField.text == nil {
                
            } else {
                underlineView[0].backgroundColor = .macoOrange
                nameTextField.text = myPetsArray[currentCellNum].name
            }
            
            if myPetsArray[currentCellNum].startDate != nil {
                underlineView[1].backgroundColor = .macoOrange
                calendarButton.imageView?.image = UIImage(named: "icCalendarFill")
                becomeFamilyDateLabel.textColor = .macoBlack
                becomeFamilyDateLabel.text = myPetsArray[currentCellNum].startDate
            } else {
                calendarButton.imageView?.image = UIImage(named: "icCalendarEmpty")
            }
            
            if myPetsArray[currentCellNum].kind == 1 {
                setSelectedButton(dogButton)
            } else if myPetsArray[currentCellNum].kind == 2 {
                setSelectedButton(catButton)
            } else {
                catButton.isSelected = false
                dogButton.isSelected = false
                catButton.setBackgroundColor(.macoWhite, for: .normal)
                dogButton.setBackgroundColor(.macoWhite, for: .normal)
            }
            
            if myPetsArray[currentCellNum].gender == 0 {
                setSelectedButton(genderButton[0])
            } else if myPetsArray[currentCellNum].gender == 1 {
                setSelectedButton(genderButton[1])
            } else if myPetsArray[currentCellNum].gender == 2 {
                setSelectedButton(genderButton[2])
            } else {
                genderButton[0].isSelected = false
                genderButton[1].isSelected = false
                genderButton[2].isSelected = false
                genderButton[0].setBackgroundColor(.macoWhite, for: .normal)
                genderButton[1].setBackgroundColor(.macoWhite, for: .normal)
                genderButton[2].setBackgroundColor(.macoWhite, for: .normal)
            }
        }
    }

    // MARK: - Set CollectionViewCell
    func setPlusCell(_ sender: MakePlusCollectionViewCell, _ color: UIColor, _ index: Int) {
        sender.layer.borderWidth = 1.0
        sender.layer.cornerRadius = Constant.round3
        sender.layer.borderColor = color.cgColor
        sender.characterNumberLabel.text = "주인공 " + String(index)
        sender.characterNumberLabel.backgroundColor = color
        sender.characterNumberLabel.textColor = UIColor.white
    }
    
    func setRegisterCell(_ sender: RegisterMyPetCollectionViewCell, _ color: UIColor, _ index: Int) {
        sender.layer.cornerRadius = Constant.round3
        sender.layer.borderColor = color.cgColor
        sender.characterNumberLabel.text = "주인공 " + String(index)
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
