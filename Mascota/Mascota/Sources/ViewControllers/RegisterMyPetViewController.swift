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
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var myPetsArray = [RegisterMyPetModel]()
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
        
        //toolBar.sizeToFit()
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
        calendarButton.imageView?.image = UIImage(named: "icCalendarFill")
        datePickerBackgroundView.removeFromSuperview()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    
    @objc func cancelButtonClick() {
        datePickerBackgroundView.removeFromSuperview()
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    /*
    @objc func tapImageButton() {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in           // Cancel버튼 눌렀을 때 뭐할거야
            print("cancel")
        }
        cancelAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor") //cancel버튼 색깔입히기
        alertController.addAction(cancelAction)
        
        let showlibraryAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in  self.openLibrary()    }
        
        showlibraryAction.setValue(UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1), forKey: "titleTextColor") //ok버튼 색깔입히기
        alertController.addAction(showlibraryAction)
        
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        alertController.view.layer.masksToBounds = true
        alertController.view.layer.cornerRadius = 3.0
        
        let attributedString = NSAttributedString(string: "프로필 사진 등록하기", attributes: [ //타이틀 폰트사이즈랑 글씨
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0) ,
            NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        ])
        alertController.setValue(attributedString, forKey: "attributedMessage")
        
        present(alertController, animated: true)
    }
    */
     
    // MARK: - Navigation Bar
    
    func setNavigationBar() {
        self.navigationBar.backgroundColor = .macoIvory
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.macoBlack]
        self.navigationController?.navigationBar.shadowImage = nil
        //self.navigationItem.backBarButtonItem?.image = UIImage(named: "btnIconBack")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setButtons()
        setDateLabelPlaceholder()
        appendEmptyElement()
        registerCollectionView()
        registerCollectionViewCell()
    }
    
    func appendEmptyElement() {
        myPetsArray.append(RegisterMyPetModel(petImage: UIImage(named: "yeonseo") ?? UIImage(), petName: "", petKind: "", familyDate: "", petGender: ""))
    }
    
    func setDatePickerView() {
        datePicker = UIDatePicker.init()
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

// MARK: - CollectionView
extension RegisterMyPetViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPetsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            setRegisterCell(cell, .macoOrange, indexPath.row + 1)
            print("indexpath.row")
            print(indexPath.row)
      
            cell.myPetImage.image = myPetsArray[indexPath.row].petImage
            return cell
        }
    }
/*
         switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterMyPetCollectionViewCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
                return UICollectionViewCell()
            }
            setRegisterCell(cell, .macoOrange, 1)
            cell.myPetImage.image = myPetsArray[currentCellNum].petImage
            //cell.imageViewButton.addTarget(self, action: #selector(tapImageButton), for: .touchUpInside)
            return cell
            
        case myPetsArray.count: // 마지막셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakePlusCollectionViewCell", for: indexPath) as? MakePlusCollectionViewCell else {
                return UICollectionViewCell()
            }
            setPlusCell(cell, .macoLightGray, indexPath.row + 1)
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegisterMyPetCollectionViewCell", for: indexPath) as? RegisterMyPetCollectionViewCell else {
                return UICollectionViewCell()
            }
            setRegisterCell(cell, .macoOrange, indexPath.row + 1)
            cell.myPetImage.image = myPetsArray[currentCellNum].petImage
            //cell.imageViewButton.addTarget(self, action: #selector(tapImageButton), for: .touchUpInside)
            return cell
            
        }
    }
*/
    
    // MARK: - Add CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case myPetsArray.count: // 마지막셀
            currentCellNum = indexPath.row
            myPetsArray.append(RegisterMyPetModel(petImage: UIImage(), petName: "", petKind: "", familyDate: "", petGender: ""))
            //registerPetCollectionView.reloadData()
        default:
            currentCellNum = indexPath.row
            self.openLibrary()
            
        }
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

// MARK: - ImagePicker
extension RegisterMyPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("==============현재셀넘버:================ ")
        print(currentCellNum)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myPetsArray[currentCellNum].petImage = image
            print(myPetsArray[currentCellNum].petImage)
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
