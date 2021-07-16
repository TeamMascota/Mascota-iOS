//
//  DIaryWriteSecondViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/12.
//

import UIKit
import Moya

class DiaryWriteSecondViewController: BaseViewController {
    
    lazy var indexStackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alpha = 0.0
    }
    
    let chapterService = MoyaProvider<ChapterAPI>(plugins: [MoyaLoggingPlugin()])
    let diaryService = MoyaProvider<DiaryAPI>(plugins: [MoyaLoggingPlugin()])
    
    var isToggled: Bool = false
    
    var tableContents: [IndexModel] = []
    
    var characters: [CharacterModel] = []
    
    var diaryWrite: DiaryWriteModel = DiaryWriteModel(title: "",
                                                      diaryImages: [],
                                                      contents: "",
                                                      date: "",
                                                      id: "")
    var journalTitle: String = ""
    var selectedIndex: String = ""
    
    let textViewPlaceholder: NSAttributedString = "오늘 주인공에게 어떤 일이 있었나요?".convertColorFont(color: UIColor.macoLightGray, fontSize: 14, type: .regular)
    
    var writtenJournal: String = ""
    var pickedImage: [UIImage] = []
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewBackgroundView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var indexView: UIView!
    @IBOutlet weak var indexPlaceHolderTextField: UITextField!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var indexTitleLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var indexToggleButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleUnderlineView: UIView!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var journalTextView: UITextView!
    
    private lazy var finishButton: UIButton = UIButton().then {
        $0.setBackgroundColor(UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1), for: .disabled)
        $0.setBackgroundColor(.macoOrange, for: .normal)
        $0.setAttributedTitle("작성완료".convertColorFont(color: .macoLightGray, fontSize: 20, type: .medium), for: .disabled)
        $0.setAttributedTitle("작성완료".convertColorFont(color: .macoWhite, fontSize: 20, type: .medium), for: .normal)
        $0.isEnabled = false
    }
    
    let navigationTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .medium, size: 17)
        $0.textAlignment = .center
        $0.textColor = UIColor.macoBlack
    }
    
    let navigiationRightView: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textColor = UIColor.darkGray
        $0.textAlignment = .center
        $0.text = "2/2"
    }
    
    let progressBar: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoOrange
    }


        
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNavigationBarColor()
        initializeNavigationItems()
        registerCollectionView()
        registerCollectionViewCell()
        verifyTextView()
        registerTextView()
        registerImagePicker()
        registerTextField()
        initialieButton()
        setComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChapterList()
        let encoder: JSONEncoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(characters)
            dump(data)
        } catch (let err) {
            err.localizedDescription
        }
    
    }
    
    override func viewDidLayoutSubviews() {
        self.indexStackView.layer.addBorder([.left,.bottom,.right], color: .macoLightGray, width: 1)
    }
    
    private func initialieButton() {
        self.finishButton.addTarget(self, action: #selector(touchFinishButton), for: .touchUpInside)
    }
    
    private func initializeNavigationItems() {
        navigationTitleLabel.text = "asdfadsf"
        self.navigationItem.titleView = navigationTitleLabel
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btnIconBack"), style: .plain, target: self, action: #selector(touchBackButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigiationRightView)
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
        self.dateTextField.placeholder = findToday()
        self.dateView.round(corners: [.topLeft, .topRight], cornerRadius: 3)
        self.titleView.round(corners: [.topLeft, .topRight], cornerRadius: 3)
        self.indexView.layer.borderWidth = 0.8
        self.indexView.layer.borderColor = UIColor.macoLightGray.cgColor
        self.journalTextView.setMacoTextView()
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchBegan)))
        
    }
    
    private func findToday() -> String {
        let today = Date()
        
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy.MM.dd"
        
        diaryWrite.date = date.string(from: today)
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
    
    // MARK: - Network
    
    private func postPetDiary(data: [Data]) {
        self.attachIndicator(.translucent)
        diaryService.request(.postPetDiary(characters: characters, diaryWrite: diaryWrite, images: data)) { [weak self] result in
            self?.detachIndicator()
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    self?.navigationController?.popToRootViewController(animated: true)
                } else {
                    print("error haappened")
                }

            case .failure(let err):
                print(err.localizedDescription)
            }

        }
    }
    
    private func getChapterList() {
        self.attachIndicator(.normal)
        chapterService.request(ChapterAPI.getChapterList) { [weak self] result in
            self?.detachIndicator()
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<TableContentsModel>.self, from: response.data)
                    guard let indexes = value.data?.tableContents else {
                        return
                    }
                    self?.tableContents = indexes
                    self?.layoutComponents()
                    self?.layoutStackView()
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
                                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    private func layoutComponents() {
        scrollViewBackgroundView.addSubviews(indexStackView, finishButton, progressBar)
        
        finishButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom) //
            $0.leading.equalToSuperview().inset(27)
            $0.trailing.equalToSuperview().inset(27)
            $0.height.equalTo(50)
        }
        
        indexStackView.snp.makeConstraints {
            $0.width.equalTo(indexView.snp.width)
            $0.top.equalTo(indexView.snp.bottom).inset(1)
            $0.height.equalTo(42 * tableContents.count)
            $0.leading.equalTo(indexView.snp.leading)
            $0.trailing.equalTo(indexView.snp.trailing)
        }
        
        progressBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }
    
    private func initializeNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = .macoIvory
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func layoutStackView() {
        for (index, chapter) in tableContents.enumerated() {
            let view: UIView = UIView().then {
                $0.backgroundColor = UIColor.macoWhite
            }
            
            let dropDownIndexLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 14)
                $0.textColor = UIColor.macoDarkGray
                $0.textAlignment = .left
                
                switch chapter.chapter {
                case -1:
                    $0.text = "에필로그"
                case 0:
                    $0.text = "프롤로그"
                default:
                    $0.text = "제 \(chapter.chapter)장"
                }
            }
            
            let dropDownIndexTitleLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 16)
                $0.textColor = UIColor.macoBlack
                $0.textAlignment = .left
                $0.text = chapter.chapterTitle
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
                $0.leading.equalTo(dropDownIndexLabel.snp.trailing).offset(5)
                $0.trailing.equalToSuperview().offset(21)
            }
            
        }
    }
    
    
    
    private func displayStackViewAnimation(selected: Bool = false,
                                           index: Int = 0) {
        UIView.animate(withDuration: 0.5) {
            self.indexPlaceHolderTextField.alpha = 0
            self.indexTitleLabel.alpha = 1
            self.indexLabel.alpha = 1
            self.indexStackView.arrangedSubviews[index].backgroundColor = .macoWhite
            self.indexToggleButton.transform = self.isToggled ? CGAffineTransform(rotationAngle: .pi * 2): CGAffineTransform(rotationAngle: .pi)
            self.indexStackView.alpha = self.isToggled ? 0.0 : 1.0
        }
        isToggled.toggle()
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
    
    private func isFinishButtonAvailable() {
        if diaryWrite.isEmpty() {
            self.finishButton.isEnabled = false
        }
        self.finishButton.isEnabled = true
    }
    
    @objc
    private func touchBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func touchBegan() {
        self.view.endEditing(true)
    }
    
    @objc
    func titleTextFieldChanged(_ sender: UITextField) {
        guard let cnt = sender.text?.count else {
            return
        }
        titleCountLabel.setCountLabel(current: cnt, limit: 11)
        
    }
    
    @objc
    func touchFinishButton() {
        var data: [Data] = []
        pickedImage.forEach {
            guard let image = $0.pngData() else {
                print("cannot convert to PNG")
                return
            }
            data.append(image)
        }
        
        self.postPetDiary(data: data)
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
        guard let index = sender.view?.tag else {
            return
        }
        switch tableContents[index].chapter {
        case 0:
            self.indexLabel.text = "프롤로그"
        case -1:
            self.indexLabel.text = "에필로그"
        default:
            self.indexLabel.text = "제 \(tableContents[index].chapter)장"
        }
        
        diaryWrite.id = tableContents[index].chapterID
        isFinishButtonAvailable()
        self.indexTitleLabel.text = tableContents[index].chapterTitle
        indexStackView.arrangedSubviews[index].backgroundColor = .macoIvory
        displayStackViewAnimation(selected: true, index: index)
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
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else {
            return
        }
        diaryWrite.contents = text
        isFinishButtonAvailable()
    }
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.titleUnderlineView.backgroundColor = .macoOrange
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        if text.count <= 11 {
            journalTitle = text
            self.titleUnderlineView.backgroundColor = .macoOrange
            diaryWrite.title = text
            isFinishButtonAvailable()
            
        } else {
            journalTitle = ""
            textField.text = ""
            self.titleUnderlineView.backgroundColor = .macoLightGray
            self.titleCountLabel.text = "(0/11)"
        }
        return true
    }
    
}
