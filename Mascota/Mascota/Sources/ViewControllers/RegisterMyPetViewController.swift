//
//  RegisterMyPetViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/04.
//

import UIKit

class RegisterMyPetViewController: UIViewController {
    
    let customLabelAlertView = CustomLabelAlertView()

    enum ChangedCellLayout {
      case deleted
      case append
      case defaultClick
    }
    
    var temp: ChangedCellLayout = .append
    var tempNum = 0

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
    @IBOutlet var nextButton: UIButton!

    var myPetsArray = [PetInfo]()
    var myPetImageArray = [UIImage]()
    
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()
    let picker = UIImagePickerController()
    var datePickerBackgroundView = UIView()
    var currentCellNum = 0
    
    //MARK: - Layout
    @IBOutlet weak var collectionViewTopLayout: NSLayoutConstraint!
    @IBOutlet weak var collectionViewBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var doneLabelBotttomLayout: NSLayoutConstraint!
    @IBOutlet weak var nameLabelBotttomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var nameTextFieldBottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewBottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var familyLabelBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var startLabelBottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var genderLabelBottomLayout: NSLayoutConstraint!
    
    // MARK: - Alert Handlers
    var deleteHandler: ((UIAlertAction) -> Void)?
    var dismissHandler: ((UIAlertAction) -> Void)?
    
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
        let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterPrologBookViewController") as? RegisterPrologBookViewController
        nextVC?.totalpet = String(myPetsArray.count)
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    private func initializeHandlers() {
        self.deleteHandler = { _ in
            self.dismiss(animated: true, completion: nil)
        }

        self.dismissHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            print("dismissed")

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
            myPetsArray[currentCellNum].startDate = becomeFamilyDateLabel.text ?? ""
        }
    }
    
    @objc func onDoneButtonClick() {
        becomeFamilyDateLabel.font = .macoFont(type: .regular, size: 16.0)
        becomeFamilyDateLabel.textColor = .macoBlack
        calendarButton.setImage(UIImage(named: "icCalendarFill"), for: .normal)
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
        self.customLabelAlertView.setTitle(text: "프로필 삭제")
        let description = "작성 중이던 주인공 \(sender.tag + 1)의 프로필 정보가 모두 사라집니다. 프로필삭제하시겠어요?".convertSomeColorFont(color: UIColor.macoBlack, fontSize: 14, type: .medium, start: 0, length: 0)
        self.customLabelAlertView.setAttributedDescription(attributedText: description)
        
        self.presentDoubleCustomAlert(view: customLabelAlertView, preferredSize: CGSize(width: 270, height: 130), firstHandler: dismissHandler, secondHandler: {_ in
            print("currentCellnum")
            print(self.currentCellNum)
            print("어레이 개수")
            print(self.myPetsArray.count)
            if self.currentCellNum == 0 { //첫번짺꺼 눌렀을 때
                if self.myPetsArray.count == 1 {
                   // self.myPetsArray.remove(at: 0)
                    self.setDateLabelPlaceholder()
                    self.resetComponents()
                    //self.myPetsArray[0] = PetInfo(petImages: UIImage(named: "yeonseo")!, name: nil, kind: nil, startDate: nil, gender: nil)
                    
                    //self.temp = .append
                } else { //여러개일때
                    self.myPetsArray.remove(at: 0)
                    self.forwordInfoAfterDelete(deleteNum: sender.tag)
                }
                
            } else if self.currentCellNum == self.myPetsArray.count - 1 {//마지막꺼 눌렀을 때
                print("마지막 셀 지울 때!!")
                self.deleteLastCell()
                self.myPetsArray.remove(at: self.currentCellNum)
            } else { //2번째 이상 눌렀을 때
                self.myPetsArray.remove(at: sender.tag)
                self.forwordInfoAfterDelete(deleteNum: sender.tag)
            }
            self.tempNum = sender.tag
            self.registerPetCollectionView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }, firstText: "취소", secondText: "삭제")
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
        setFirstNumberDoneLabel()
        appendEmptyElement()
        registerCollectionView()
        disalbeButton(nextButton)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkNotch()
    }
    
    func checkNotch() {
        if UIDevice.current.hasNotch {
        } else {
            collectionViewBottomLayout.constant = collectionViewBottomLayout.constant / 3
            nameLabelBotttomLayout.constant = nameLabelBotttomLayout.constant / 2
            familyLabelBottomLayout.constant = familyLabelBottomLayout.constant / 2
            startLabelBottomLayout.constant = startLabelBottomLayout.constant / 2
        }
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
    
    func ableButton(_ sender: UIButton) {
        sender.layer.masksToBounds = true
        sender.layer.cornerRadius = Constant.round3
        sender.isEnabled = true
        sender.backgroundColor = .macoOrange
        sender.setTitleColor(.macoWhite, for: .normal)
    }
    
    func disalbeButton(_ sender: UIButton) {
        sender.layer.masksToBounds = true
        sender.layer.cornerRadius = Constant.round3
        sender.isEnabled = false
        sender.backgroundColor = UIColor(red: 229.0/255.0, green: 228.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        sender.setTitle("다음", for: .normal)
        sender.setTitleColor(.macoLightGray, for: .normal)
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
        becomeFamilyDateLabel.font = .macoFont(type: .regular, size: 14.0)
    }
    
    func resetComponents() {
        disalbeButton(nextButton)
        underlineView[0].backgroundColor = .lightGray
        underlineView[1].backgroundColor = .lightGray
        nameTextField.text = nil
        namelengthLabel.text = "(0/6)"
        catButton.isSelected = false
        dogButton.isSelected = false
        genderButton[0].isSelected = false
        genderButton[1].isSelected = false
        genderButton[2].isSelected = false
        catButton.setBackgroundColor(.macoWhite, for: .normal)
        dogButton.setBackgroundColor(.macoWhite, for: .normal)
        setDateLabelPlaceholder()
        calendarButton.setImage(UIImage(named: "icCalendarEmpty"), for: .normal)
        //calendarButton.imageView?.image = UIImage(named: "icCalendarEmpty")
        genderButton[0].setBackgroundColor(.macoWhite, for: .normal)
        genderButton[1].setBackgroundColor(.macoWhite, for: .normal)
        genderButton[2].setBackgroundColor(.macoWhite, for: .normal)
    }
    
    func setAlertView() {
            self.customLabelAlertView.setTitle(text: "경고")
            let description = "지금 작성 중인 프로필부터 작성 완료해야 \n 주인공을 추가할 수 있습니다.".convertSomeColorFont(color: UIColor.macoBlack, fontSize: 14, type: .medium, start: 0, length: 0)
            self.customLabelAlertView.setAttributedDescription(attributedText: description)
            self.presentSingleCustomAlert(view: customLabelAlertView, preferredSize: CGSize(width: 270, height: 130), confirmHandler: nil, text: "확인", color: .macoOrange)
        }
    
    func deleteLastCell() {
        resetComponents()
        temp = .deleted
        
        self.nameLabel.text = "주인공 \(currentCellNum)의 이름"
        
        self.nameTextField.text = self.myPetsArray[currentCellNum-1].name
        
        if (myPetsArray[currentCellNum-1].kind == 1) {
            dogButton.isSelected = true
        } else {
            catButton.isSelected = true
        }
        
        calendarButton.setImage(UIImage(named: "icCalendarFill"), for: .normal)
        
        self.becomeFamilyDateLabel.text = self.myPetsArray[currentCellNum-1].startDate
        self.becomeFamilyDateLabel.font = .macoFont(type: .regular, size: 16.0)
        self.becomeFamilyDateLabel.textColor = .macoBlack
        
        if (myPetsArray[currentCellNum - 1].gender == 0) {
            genderButton[0].isSelected = true
        } else if (myPetsArray[currentCellNum - 1].gender == 1) {
            genderButton[1].isSelected = true
        } else {
            genderButton[2].isSelected = true
        }
    }
    
    func forwordInfoAfterDelete(deleteNum: Int) {
        temp = .deleted
        resetComponents()
        
        self.nameLabel.text = "주인공 \(deleteNum + 1)의 이름"
        
        self.nameTextField.text = self.myPetsArray[deleteNum].name
        
        if (myPetsArray[deleteNum].kind == 1) {
            dogButton.isSelected = true
        } else {
            catButton.isSelected = true
        }
        
        calendarButton.setImage(UIImage(named: "icCalendarFill"), for: .normal)
        
        self.becomeFamilyDateLabel.text = self.myPetsArray[deleteNum].startDate
        self.becomeFamilyDateLabel.font = .macoFont(type: .regular, size: 16.0)
        self.becomeFamilyDateLabel.textColor = .macoBlack
        
        if (myPetsArray[deleteNum].gender == 0) {
            genderButton[0].isSelected = true
        } else if (myPetsArray[deleteNum].gender == 1) {
            genderButton[1].isSelected = true
        } else {
            genderButton[2].isSelected = true
        }
    }
    
    func setNumberOfDoneLabel() {
        numberOfDonePetLabel.textColor = .macoGray
        numberOfDonePetLabel.attributedText = "현재 작성 완료된 반려동물 주인공 \(myPetsArray.count - 1)마리".convertSomeColorFont(color: .macoOrange, fontSize: 20, type: .regular, start: 19, length: 1)
        numberOfDonePetLabel.font = .macoFont(type: .regular, size: 14.0)
    }
    
    func setFirstNumberDoneLabel() {
        numberOfDonePetLabel.textColor = .macoGray
        numberOfDonePetLabel.attributedText = "현재 작성 완료된 반려동물 주인공 0마리".convertSomeColorFont(color: .macoOrange, fontSize: 20, type: .regular, start: 19, length: 1)
        numberOfDonePetLabel.font = .macoFont(type: .regular, size: 14.0)
    }
}

// MARK: - TextField Delegate
extension RegisterMyPetViewController: UITextFieldDelegate {
    func setTextField() {
        self.nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if nameTextField.text!.isEmpty {
            disalbeButton(nextButton)
        } else {
            if myPetsArray[currentCellNum].kind != nil && myPetsArray[currentCellNum].gender != nil && myPetsArray[currentCellNum].startDate != nil {
                ableButton(nextButton)
            } else {
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1.0)
                nextButton.titleLabel?.textColor = .macoLightGray
                disalbeButton(nextButton)
            }
        }
        if nameTextField.text!.count == 0 {
            underlineView[0].backgroundColor = .macoLightGray
        } else {
            underlineView[0].backgroundColor = .macoOrange
        }
        namelengthLabel.setCountLabel(current: nameTextField.text!.count, limit: 6)
       // namelengthLabel.text = "(" + String(nameTextField.text!.count) + "/6)"
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
            
            if myPetsArray.count == 1 && indexPath.row == 0 {
                cell.closeButton.isHidden = true
            } else {
                cell.closeButton.isHidden = false
            }
            
            if temp == .deleted {
                isSelectedFalseAll()
                print("temp: deleted!")
                if indexPath.item == tempNum {
                    cell.isSelected = true
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                }
            } else if temp == .defaultClick {
                isSelectedFalseAll()
                print("temp: defaultClick!")
                if indexPath.item == currentCellNum {
                    cell.isSelected = true
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                }
            } else {
                isSelectedFalseAll()
                print("temp: else!")
                if indexPath.item == myPetsArray.count - 1 {
                    cell.isSelected = true
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                }
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
    
    func isSelectedFalseAll() {
        for i in 0...myPetsArray.count - 1 {
            let indexPath = IndexPath(item: i, section: 0);
            guard let cell = registerPetCollectionView.cellForItem(at: indexPath) as? RegisterMyPetCollectionViewCell else {
                return
            }
            
            cell.isSelected = false
        }
    }
    
    // MARK: - Add CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentCellNum = indexPath.row
        
        isSelectedFalseAll()
        
        switch indexPath.row {
        case myPetsArray.count: // 마지막셀
            temp = .append
            if myPetsArray.count == 1 { // 1마리일 때
                if myPetsArray[0].gender != nil && myPetsArray[0].kind != nil && myPetsArray[0].name != nil && myPetsArray[0].startDate != nil {
                    resetComponents()
                   myPetsArray.append(PetInfo(petImages: UIImage(), name: nil, kind: nil, startDate: nil, gender: nil))
                    nameLabel.text = "주인공 " + String(indexPath.row+1) + "의 이름"
                   registerPetCollectionView.reloadData()
                } else {
                    nameLabel.text = "주인공 " + String(indexPath.row) + "의 이름"
                    setAlertView()
                    temp = .append
                    currentCellNum = 0
                    registerPetCollectionView.reloadData()
                }
            } else { //1마리 이상일 때
                if myPetsArray[currentCellNum - 1].gender != nil && myPetsArray[currentCellNum - 1].kind != nil && myPetsArray[currentCellNum - 1].name != nil && myPetsArray[currentCellNum - 1].startDate != nil {
                    resetComponents()
                   myPetsArray.append(PetInfo(petImages: UIImage(), name: nil, kind: nil, startDate: nil, gender: nil))
                    nameLabel.text = "주인공 " + String(indexPath.row+1) + "의 이름"
                   registerPetCollectionView.reloadData()
                } else {
                    nameLabel.text = "주인공 " + String(indexPath.row) + "의 이름"
                    setAlertView()
                    temp = .append
                    registerPetCollectionView.reloadData()
                    currentCellNum = indexPath.row - 1
                }
            }
            setNumberOfDoneLabel()
        default:
            temp = .defaultClick
            guard let cell = collectionView.cellForItem(at: indexPath) as? RegisterMyPetCollectionViewCell else{
                return
            }
            cell.isSelected = true
            nameLabel.text = "주인공 " + String(indexPath.row + 1) + "의 이름"
            currentCellNum = indexPath.row
            resetComponents()
            
            if myPetsArray[currentCellNum].petImages == UIImage(named: "yeonseo") || myPetsArray[currentCellNum].petImages == UIImage() {
                cell.myPetImage.image = UIImage(named: "yeonseo")
                registerPetCollectionView.reloadData()
            } else {
                cell.myPetImage.image = myPetsArray[currentCellNum].petImages
                registerPetCollectionView.reloadData()
            }
            
            if nameTextField.text == nil {
                
            } else {
                underlineView[0].backgroundColor = .macoOrange
                nameTextField.text = myPetsArray[currentCellNum].name
                
                guard let nameLength = nameTextField.text?.count else {return}
                namelengthLabel.text = "(\(nameLength)/6)"
            }
            
            if myPetsArray[currentCellNum].startDate != nil {
                underlineView[1].backgroundColor = .macoOrange
                calendarButton.setImage(UIImage(named: "icCalendarFill"), for: .normal)
                becomeFamilyDateLabel.text = myPetsArray[currentCellNum].startDate
                becomeFamilyDateLabel.textColor = .macoBlack
                becomeFamilyDateLabel.font = .macoFont(type: .regular, size: 16.0)
            } else {
                calendarButton.setImage(UIImage(named: "icCalendarEmpty"), for: .normal)
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
        setNumberOfDoneLabel()
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
