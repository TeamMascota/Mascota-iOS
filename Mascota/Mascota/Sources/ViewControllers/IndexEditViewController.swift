//
//  IndexEditViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

import SnapKit
import Then

class IndexEditViewController: UIViewController {

    // MARK: - Properities 선언
    @IBOutlet weak var separatorView: UIView!
    
    var cellCnt = 40
    
    lazy var indexCollectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                                      collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.macoIvory
    }
    
    var customTextFieldAlertView = CustomTextFieldAlertView()
    var customLabelAlertView = CustomLabelAlertView()

    // Alert Handlers
    var deleteHandler: ((UIAlertAction) -> Void)?
    var confirmHandler: ((UIAlertAction) -> Void)?
    var dismissHandler: ((UIAlertAction) -> Void)?
    var saveHandler: ((UIAlertAction) -> Void)?
    var afterDeleted: (() -> Void)?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        layoutComponents()
        registerCollectionView()
        registerCollectionViewCell()
        registerTextField()
        initializeHandlers()
        // Do any additional setup after loading the view.
    }
    
    private func initializeHandlers() {
        self.confirmHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            print("confirmed")

        }
        self.deleteHandler = { _ in
            self.customLabelAlertView.setTitle(text: "삭제 완료")
            let description = "title 목차가 삭제됐어요".convertSomeColorFont(color: UIColor.macoBlack,
                                                                        fontSize: 14,
                                                                        type: .medium,
                                                                        start: 0,
                                                                        length: 5)
            self.customLabelAlertView.setAttributedDescription(attributedText: description)
            self.dismiss(animated: true, completion: nil)
        }
        self.dismissHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            print("dismissed")

        }
        self.saveHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            print("saved")
        }
        
        self.afterDeleted = {
            self.presentSingleCustomAlert(view: self.customLabelAlertView,
                                          preferredSize: CGSize(width: 270, height: 100),
                                          confirmHandler: self.dismissHandler,
                                          text: "확인")
        }
    }
    
    // MARK: - Private Functions
    
    // 텍스트필드 등록
    private func registerTextField() {
        self.customTextFieldAlertView.alertTextField.delegate = self
        self.customTextFieldAlertView.alertTextField.addTarget(self, action: #selector(textFieldEditing(_:)), for: .editingChanged)
    }
    
    private func registerCollectionView() {
        indexCollectionView.delegate = self
        indexCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.indexEditCollectionViewCell,
                                                bundle: nil), forCellWithReuseIdentifier: AppConstants.CollectionViewCells.indexEditCollectionViewCell)
        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.indexEditPrologueCollectionViewCell,
                                                bundle: nil), forCellWithReuseIdentifier: AppConstants.CollectionViewCells.indexEditPrologueCollectionViewCell)
        self.indexCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.mascotaPeopleImageCell,
                                                bundle: nil),
                                          forCellWithReuseIdentifier: AppConstants.CollectionViewCells.mascotaPeopleImageCell)
    }
    
    private func layoutComponents() {
        self.view.addSubview(indexCollectionView)
        
        indexCollectionView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc
    func textFieldEditing(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        self.customTextFieldAlertView.setTextFieldCountLabel(length: text.count)
    }
    
    @objc
    func touchDeleteButton(_ sender: UIButton) {
        self.customLabelAlertView.setTitle(text: "목차 삭제")
//        guard let title = 타이틀 이름
//        let description = "목차와 이야기가 모두 사라집니다.\n" + title + "을 삭제하시겠어요?"
        let description = "목차와 이야기가 모두 사라집니다.\ntitle을 삭제하시겠어요?".convertSomeColorFont(color: UIColor.macoBlack,
                                                                                              fontSize: 14,
                                                                                              type: .medium,
                                                                                              start: 19,
                                                                                              length: 5)
        self.customLabelAlertView.setAttributedDescription(attributedText: description)
        self.presentDoubleCustomAlert(view: customLabelAlertView,
                                      preferredSize: CGSize(width: 270, height: 130),
                                      firstHandler: dismissHandler,
                                      secondHandler: deleteHandler,
                                      firstText: "취소",
                                      secondText: "삭제")
    }
    
    @objc
    func touchChangeButton(_ sender: UIButton) {
        self.customTextFieldAlertView.initializeComponents(title: "\(sender.tag)", textField: nil)
        self.presentDoubleCustomAlert(view: customTextFieldAlertView,
                                      preferredSize: CGSize(width: 270, height: 100),
                                      firstHandler: dismissHandler,
                                      secondHandler: saveHandler,
                                      firstText: "취소", secondText: "저장")
    }
    
    @IBAction func touchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        self.customTextFieldAlertView.initializeComponents(title: "목차 추가", textField: nil)
        self.presentDoubleCustomAlert(view: customTextFieldAlertView,
                                      preferredSize: CGSize(width: 270, height: 100),
                                      firstHandler: dismissHandler,
                                      secondHandler: saveHandler,
                                      firstText: "취소",
                                      secondText: "저장")
        print("touchPlusButton")
    }

}

// MARK: - UICollecitonView DataSource

extension IndexEditViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return cellCnt
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            // 셀이 2개 사용되기 때문에 분기
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.indexEditPrologueCollectionViewCell,
                                                                    for: indexPath) as? IndexEditPrologueCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.intializeData(indexPath.item)
                cell.changeButton.addTarget(self,
                                            action: #selector(touchChangeButton(_:)),
                                            for: .touchUpInside)
                cell.deleteButton.addTarget(self,
                                            action: #selector(touchDeleteButton(_:)),
                                            for: .touchUpInside)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.indexEditCollectionViewCell,
                                                                    for: indexPath) as? IndexEditCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.intializeData(indexPath.item)
                cell.changeButton.addTarget(self,
                                            action: #selector(touchChangeButton(_:)),
                                            for: .touchUpInside)
                cell.deleteButton.addTarget(self,
                                            action: #selector(touchDeleteButton(_:)),
                                            for: .touchUpInside)
                return cell
            }
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.mascotaPeopleImageCell, for: indexPath) as? MascotaPeopleImageCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
    }

}

// MARK: - UICollection View Delegate
extension IndexEditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 41)
        default:
            // 목록이 한 화면은 다 채우지 않으면 이미지가 화면 밑으로 가게끔 조정
            let cellsHeight = CGFloat(41 * cellCnt)
            let freeSpace = collectionView.bounds.height - cellsHeight
            let height = freeSpace > 142 ? freeSpace: 142
            return CGSize(width: collectionView.bounds.width,
                          height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - UITextFieldDelegate
extension IndexEditViewController: UITextFieldDelegate {
    // 엔터키 눌렀을 때 텍스트뷰 비활
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
    }
}
