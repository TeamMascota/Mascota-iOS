//
//  DIaryWriteSecondViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/12.
//

import UIKit

class DiaryWriteSecondViewController: UIViewController {
    
    lazy var indexStackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alpha = 0.0
    }
    
    var isToggled: Bool = false
    
    let temp: [String] = ["", "1장", "2장", "3장", "4장", "5장"]
    
    let textViewPlaceholder: NSAttributedString = "오늘 주인공에게 어떤 일이 있었나요?".convertColorFont(color: UIColor.macoLightGray, fontSize: 14, type: .regular)
    
    var writtenJournal: String = ""
    var pickedImage: [UIImage] = []
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var scrollViewBackgroundView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var indexView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var indexTitleLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var indexToggleButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    
    // 스크롤뷰에서 먹히지 않기 때문에 scrollView에 탭 제스처를 붙여서 처리해줘야 됨
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        print(1)
//        self.view.endEditing(true)
//    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        registerCollectionViewCell()
        verifyTextView()
        registerTextView()
        registerImagePicker()
        registerTextField()
        layoutComponents()
        layoutStackView()
        setComponents()
        
    }
    
    override func viewDidLayoutSubviews() {
        self.indexStackView.layer.addBorder([.left,.bottom,.right], color: .macoLightGray, width: 1)
    }
    
    private func registerImagePicker() {
        self.imagePicker.delegate = self
    }
    
    private func registerTextField() {
        titleTextField.delegate = self
        titleTextField.addTarget(self, action: #selector(titleTextFieldChanged(_:)), for: .editingChanged)
    }
    private func registerTextView() {
        journalTextView.delegate = self
    }
    
    private func verifyTextView() {
        if self.journalTextView.text?.count == 0 {
            self.journalTextView.attributedText = textViewPlaceholder
        }
    }
    private func setComponents() {
        self.indexLabel.isHidden = true
        self.indexTitleLabel.isHidden = true
        self.dateTextField.placeholder = findToday()
        self.dateView.round(corners: [.topLeft, .topRight], cornerRadius: 3)
        self.titleView.round(corners: [.topLeft, .topRight], cornerRadius: 3)
        self.indexView.layer.borderWidth = 0.8
        self.indexView.layer.borderColor = UIColor.macoLightGray.cgColor
        self.journalTextView.setMacoTextView()
        
    }
    
    private func findToday() -> String {
        let today = Date()
        
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy.MM.dd"

        return date.string(from: today)
    }
    
    private func registerCollectionViewCell() {
        self.imageCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.plusCollectionViewCell,
                                                bundle: nil),
                                          forCellWithReuseIdentifier: AppConstants.CollectionViewCells.plusCollectionViewCell)
        
        self.imageCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.imageCollectionViewCell,
                                                bundle: nil),
                                          forCellWithReuseIdentifier: AppConstants.CollectionViewCells.imageCollectionViewCell)
    }
    
    private func registerCollectionView() {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
    }
    
    private func presentImagePickerController(method: UIImagePickerController.SourceType) {
        self.imagePicker.sourceType = method
        self.imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func layoutComponents() {
        scrollViewBackgroundView.addSubview(indexStackView)
        
        indexStackView.snp.makeConstraints {
            $0.width.equalTo(indexView.snp.width)
            $0.top.equalTo(indexView.snp.bottom).inset(1)
            $0.height.equalTo(42 * temp.count)
            $0.leading.equalTo(indexView.snp.leading)
            $0.trailing.equalTo(indexView.snp.trailing)
        }
    }
    
    
    private func layoutStackView() {
        for (index, text) in temp.enumerated() {
            let view: UIView = UIView().then {
                $0.backgroundColor = UIColor.macoWhite
            }
            
            
            let dropDownIndexLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 14)
                $0.textColor = UIColor.macoDarkGray
                $0.textAlignment = .left
                $0.text = index == 0 ? "프롤로그" : "제 \(index)장"
            }
            
            let dropDownIndexTitleLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 16)
                $0.textColor = UIColor.macoBlack
                $0.textAlignment = .left
                $0.text = text
            }
            
            indexStackView.addArrangedSubview(view)
            view.addSubviews(dropDownIndexLabel, dropDownIndexTitleLabel)
            
            view.snp.makeConstraints {
                $0.height.equalTo(42)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            view.tag = index
            view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(touchDropDownView(_:))))

            
            dropDownIndexLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.equalTo(55)
                $0.leading.equalToSuperview().offset(21)
            }
            
            dropDownIndexTitleLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(dropDownIndexLabel.snp.trailing).offset(-5)
                $0.trailing.equalToSuperview().offset(21)
            }
            
        }
    }
    
    private func presentActionSheet(delete: Bool, index: Int = 100) {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if delete {
            let deleteHandler = UIAlertAction.init(title: "사진 삭제", style: .default) { _ in
                self.pickedImage.remove(at: index)
                self.imageCollectionView.reloadData()
            }
            deleteHandler.setValue(UIColor.macoBlack, forKey: "titleTextColor")
            alert.addAction(deleteHandler)
        }
    
        let photoLibraryHandler = UIAlertAction.init(title: "앨범에서 사진 선택", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.presentImagePickerController(method: .photoLibrary)
            } else {
                print("can't approach Photo Library")
            }
        }
        
        let cancelHandler = UIAlertAction.init(
                title: "취소",
                style: .cancel,
                handler: nil)
        
        photoLibraryHandler.setValue(UIColor.macoBlack, forKey: "titleTextColor")
        cancelHandler.setValue(UIColor.macoBlack, forKey: "titleTextColor")
        
        alert.addAction(photoLibraryHandler)
        alert.addAction(cancelHandler)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func titleTextFieldChanged(_ sender: UITextField) {
        guard let cnt = sender.text?.count else {
            return
        }
        titleCountLabel.text = "\(cnt)/11"
    }
    
    @objc
    func touchPlusButton() {
        presentActionSheet(delete: false)
    }
    
    @objc
    func touchImageCell(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else {
            return
        }
        if index < pickedImage.count {
            presentActionSheet(delete: true, index: index)
        }
    }
    
    @objc
    func touchDropDownView(_ sender: UITapGestureRecognizer) {
        print(1)
    }
    
    
    @IBAction func touchToggleButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.indexToggleButton.transform = self.isToggled ? CGAffineTransform(rotationAngle: .pi * 2): CGAffineTransform(rotationAngle: .pi)
            self.indexStackView.alpha = self.isToggled ? 0.0 : 1.0
        }
        isToggled.toggle()
    }
    
}

extension DiaryWriteSecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension DiaryWriteSecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.plusCollectionViewCell,
                                                                for: indexPath) as? PlusCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchPlusButton)))
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.imageCollectionViewCell, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.tag = indexPath.item - 1
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchImageCell(_:))))
        if indexPath.item <= pickedImage.count {
            cell.initializeCell(data: pickedImage[indexPath.item - 1])
        } else {
            cell.initializeCell(data: nil)
        }
        return cell
    }
}

extension DiaryWriteSecondViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    
        if textView.attributedText == textViewPlaceholder {
            textView.text = ""
            textView.font = UIFont.macoFont(type: .regular, size: 16)
            textView.textColor = .macoBlack
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text?.count == 0 {
            textView.attributedText = textViewPlaceholder
        }
        
        return true
    }
}

extension DiaryWriteSecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickedImage.append(image)
            imageCollectionView.reloadData()
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImage.append(image)
            imageCollectionView.reloadData()
            self.dismiss(animated: true, completion: nil)
            return
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DiaryWriteSecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
    }
}
