//
//  IndexEditViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

import Moya
import SnapKit
import Then

class IndexEditViewController: UIViewController {

    // MARK: - Properities 선언
    
    let service = MoyaProvider<ChapterAPI>(plugins: [MoyaLoggingPlugin()])
    
    var tableContents: [IndexModel] = []
    var selectedContents: IndexModel?
    
    var writtenChapter: String = ""
    
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
    var changeHandler: ((UIAlertAction) -> Void)?
    var afterDeleted: (() -> Void)?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        layoutComponents()
        getChapterList()
        registerCollectionView()
        registerCollectionViewCell()
        registerTextField()
        initializeHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChapterList()
        setRainbowNavigationBar()
    }
    
    private lazy var backButton = UIBarButtonItem().then {
        $0.backBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(touchBackButton(_:)))
    }
    private lazy var plusButton = UIBarButtonItem().then {
        $0.plusBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(touchPlusButton(_:)))
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoBlue, tintColor: .macoWhite, underLineColor: .macoWhite)
        navigationItem.setTitle(title: "목차 편집")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func getChapterList() {
        service.request(ChapterAPI.getChapterList) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<TableContentsModel>.self, from: response.data)
                    self?.reloadCollectionView(tableContentsModel: value)
                } catch(let err) {
                    print(err.localizedDescription)
                }
                                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    private func reloadCollectionView(tableContentsModel: GenericModel<TableContentsModel>) {
        guard let contents = tableContentsModel.data?.tableContents else {
            return
        }
        self.tableContents = contents
        self.indexCollectionView.reloadData()
        
    }
    
    private func postChapterList() {
        service.request(ChapterAPI.postChapterList(title: writtenChapter)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<TableContentsModel>.self, from: response.data)
                    self?.reloadCollectionView(tableContentsModel: value)
                } catch(let err) {
                    print(err.localizedDescription)
                }
                                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    private func putChapterList() {
        guard let chapterID = selectedContents?.chapterID else {
            return
        }
        service.request(ChapterAPI.putChapterList(chapterID: chapterID, title: writtenChapter)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<TableContentsModel>.self, from: response.data)
                    self?.reloadCollectionView(tableContentsModel: value)
                } catch(let err) {
                    print(err.localizedDescription)
                }
                                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    private func deleteChapterList() {
        guard let chapterID = selectedContents?.chapterID else {
            return
        }
        service.request(ChapterAPI.deleteChapterList(chapterID: chapterID)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<TableContentsModel>.self, from: response.data)
                    self.reloadCollectionView(tableContentsModel: value)
                    self.presentSingleCustomAlert(view: self.customLabelAlertView,
                                                  preferredSize: CGSize(width: 270, height: 100),
                                                  confirmHandler: self.dismissHandler,
                                                  text: "확인")
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    private func initializeHandlers() {
        self.confirmHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            print("confirmed")

        }
        self.deleteHandler = { [weak self] _ in
            guard let self = self,
                  let chapterTitle = self.selectedContents?.chapterTitle else {
                return
            }
            self.customLabelAlertView.setTitle(text: "삭제 완료")
            let description = (chapterTitle + " 목차가 삭제됐어요").convertSomeColorFont(color: UIColor.macoBlack,
                                                                        fontSize: 14,
                                                                        type: .medium,
                                                                        start: 0,
                                                                        length: chapterTitle.count)
            self.customLabelAlertView.setAttributedDescription(attributedText: description)
            self.deleteChapterList()
            self.dismiss(animated: true, completion: nil)
        }
        self.dismissHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            print("dismissed")
        }
        
        self.changeHandler = {
            [weak self] _ in
                guard let self = self else {
                    return
                }
            if self.writtenChapter.count <= 11 && self.writtenChapter.count >= 1 {
                    self.putChapterList()
                    print("changed")
                }
                self.dismiss(animated: true, completion: nil)
        }
        
        self.saveHandler = { [weak self] _ in
            guard let self = self else {
                return
            }
            if self.writtenChapter.count <= 11 && self.writtenChapter.count >= 1{
                self.postChapterList()
                print("saved")
            }
            self.dismiss(animated: true, completion: nil)
           
        }
        
        self.afterDeleted = {
            
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
        writtenChapter = text
        self.customTextFieldAlertView.updateTextFieldCountLabel(length: text.count, limit: 11)
    }
    
    @objc
    func touchDeleteButton(_ sender: UIButton) {
        self.customLabelAlertView.setTitle(text: "목차 삭제")
        selectedContents = self.tableContents[sender.tag]
        guard let chapterTitle = selectedContents?.chapterTitle else {
            return
        }
        let description = ("목차와 이야기가 모두 사라집니다.\n" + chapterTitle + "을 삭제하시겠어요?").convertSomeColorFont(color: UIColor.macoBlack,
                                              fontSize: 14,
                                              type: .medium,
                                              start: 19,
                                              length: chapterTitle.count)
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
        selectedContents = self.tableContents[sender.tag]
        self.customTextFieldAlertView.initializeComponents(title: "제 \(sender.tag)장", textField: nil)
        self.presentDoubleCustomAlert(view: customTextFieldAlertView,
                                      preferredSize: CGSize(width: 270, height: 100),
                                      firstHandler: dismissHandler,
                                      secondHandler: changeHandler,
                                      firstText: "취소", secondText: "저장")
    }
    
    @objc
    func touchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func touchPlusButton(_ sender: Any) {
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
            return tableContents.count
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
                cell.intializeData(indexModel: tableContents[indexPath.item],tag: indexPath.item)
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
                cell.initializeData(indexModel: tableContents[indexPath.item], tag: indexPath.item)
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
            let cellsHeight = CGFloat(41 * tableContents.count)
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
