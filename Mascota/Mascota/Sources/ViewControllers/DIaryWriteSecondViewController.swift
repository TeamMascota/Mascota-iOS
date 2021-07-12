//
//  DIaryWriteSecondViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/12.
//

import UIKit

class DiaryWriteSecondViewController: UIViewController {
    
    let textViewPlaceholder: NSAttributedString = "오늘 주인공에게 어떤 일이 있었나요?".convertColorFont(color: UIColor.macoLightGray, fontSize: 14, type: .regular)
    
    var writtenJournal: String = ""
    
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
        setComponents()
        registerCollectionView()
        registerCollectionViewCell()
        verifyTextView()
        registerTextView()
        
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
        self.journalTextView.round(corners: [.topLeft, .topRight], cornerRadius: 3)
        
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
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.imageCollectionViewCell, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.initializeCell(data: nil)
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
