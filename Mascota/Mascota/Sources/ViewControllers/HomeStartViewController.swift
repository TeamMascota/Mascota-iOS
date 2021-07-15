//
//  HomeStartViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/04.
//

import UIKit

import SnapKit
import Then
import Moya

enum HomeStart: Int {
    case beforeRainbow = 0
    case afterRainbow
}

class HomeStartViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var mainNavigationBar: MainNavigationBarView = MainNavigationBarView(type: .home).then {
        $0.setNavigationBarText(title: "zzzzzzz")
    }
    
    private lazy var homeStartCollectionView: UICollectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100),
                                                                                  collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.allowsSelection = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    var homeStatus: HomeStart = .beforeRainbow
    var tableContents: [IndexModel] = []
    var firstPage: BriefDiaryModel = BriefDiaryModel(chapter: 0,
                                                     episode: 0,
                                                     id: "",
                                                     title: "",
                                                     contents: "",
                                                     date: "")
    
    let service = MoyaProvider<HomeAPI>(plugins: [MoyaLoggingPlugin()])
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getHomeFirstPart()
        layoutComponents()
        initializeComponents()
        registerCollectionViewCell()
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        getHomeFirstPart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private Functions
    // 뷰 autolayout
    private func layoutComponents() {

        self.view.addSubviews(mainNavigationBar, homeStartCollectionView)
         
        mainNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        homeStartCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainNavigationBar.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // 뷰 초기화
    private func initializeComponents() {
        self.view.backgroundColor = UIColor.macoIvory
    }
    
    private func getHomeFirstPart() {
        service.request(.getHomeFirstPart) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let value = try JSONDecoder().decode(GenericModel<HomeFirstPartModel>.self, from: response.data)
                    self?.updateServerData(serverData: value)
                } catch (let err) {
                    print(err.localizedDescription)
                }
            
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func updateServerData(serverData: GenericModel<HomeFirstPartModel>) {
        guard let title = serverData.data?.firstPartMainPage.title,
              let url = serverData.data?.firstPartMainPage.bookImg,
              let contents = serverData.data?.firstPartMainPage.tableContents,
              let diary = serverData.data?.firstPartMainPage.diary else {
            return
        }
        self.tableContents = contents
        self.firstPage = diary
        self.mainNavigationBar.setNavigationBarText(title: title)
        self.mainNavigationBar.setNavigationBarButtonImage(url: url)
        self.homeStartCollectionView.reloadData()
    }
    
    private func registerCollectionView() {
        self.homeStartCollectionView.delegate = self
        self.homeStartCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        // CollectionViewCell
        self.homeStartCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.bookPageCollectionViewCell, bundle: nil),
                                              forCellWithReuseIdentifier: AppConstants.CollectionViewCells.bookPageCollectionViewCell)
        self.homeStartCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.homeIndexCollectionViewCell, bundle: nil),
                                              forCellWithReuseIdentifier: AppConstants.CollectionViewCells.homeIndexCollectionViewCell)
        self.homeStartCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.mascotaPeopleImageCell, bundle: nil),
                                              forCellWithReuseIdentifier: AppConstants.CollectionViewCells.mascotaPeopleImageCell)
        self.homeStartCollectionView.register(UINib(nibName: AppConstants.CollectionViewCells.partCollectionViewCell, bundle: nil),
                                              forCellWithReuseIdentifier: AppConstants.CollectionViewCells.partCollectionViewCell)
        
        // Header
        self.homeStartCollectionView.register(UINib(nibName: AppConstants.CollectionViewHeaders.homeIndexCollectionReusableView, bundle: nil),
                                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: AppConstants.CollectionViewHeaders.homeIndexCollectionReusableView)
        
    }
    
    // 뷰 전환 함수
    private func pushToIndexEdit() {
        let storyboard = UIStoryboard(name: AppConstants.Storyboard.indexEdit, bundle: nil)
        guard let editViewController = storyboard.instantiateViewController(identifier: AppConstants.ViewController.indexEdit) as? IndexEditViewController else {
            return
        }
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
    private func pushToIndexDetail(chapterID: String) {
        let storyboard = UIStoryboard(name: AppConstants.Storyboard.indexDetail, bundle: nil)
        guard let indexDetailViewController = storyboard.instantiateViewController(identifier: AppConstants.ViewController.indexDetail) as? IndexDetailViewController else {
            return
        }
        indexDetailViewController.currentID = chapterID
        indexDetailViewController.tableContents = self.tableContents
        
        self.navigationController?.pushViewController(indexDetailViewController, animated: true)
    }
    
    // 편집 버튼
    @objc
    func touchEditButton(_ sender: UIButton) {
        pushToIndexEdit()
    }
    
    // 무지개 다리 이후 1부 or 2부 책 뷰 버튼
    @objc
    func touchPartDetailButton(_ sender: UIButton) {
        
    }
    
    // 목차에 chevron > 눌렀을 때
    @objc
    func touchIndexDetailButton(_ sender: UIButton) {
        print(sender.tag)
        pushToIndexDetail(chapterID: tableContents[sender.tag].chapterID)
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeStartViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch homeStatus {
        case .beforeRainbow:
            return 3
        default:
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return tableContents.count
        }
        if section == 2 {
            return 1
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.bookPageCollectionViewCell, for: indexPath) as? BookPageCollectionViewCell else {
                return UICollectionViewCell()
            }

            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.homeIndexCollectionViewCell, for: indexPath) as? HomeIndexCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.initializeData(data: tableContents[indexPath.item], tag: indexPath.item)
            cell.indexDetailButton.tag = indexPath.item
            cell.indexDetailButton.addTarget(self, action: #selector(touchIndexDetailButton(_:)), for: .touchUpInside)
            return cell
            
        case 2:
            switch homeStatus {
            case .beforeRainbow:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.mascotaPeopleImageCell, for: indexPath) as? MascotaPeopleImageCell else {
                    return UICollectionViewCell()
                }
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.partCollectionViewCell, for: indexPath) as? PartCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.partDetailButton.addTarget(self, action: #selector(touchPartDetailButton(_:)), for: .touchUpInside)
                return cell
            }
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                   withReuseIdentifier: AppConstants.CollectionViewHeaders.homeIndexCollectionReusableView,
                                                                                   for: indexPath) as? HomeIndexCollectionReusableView else {
                                                                                return UICollectionReusableView()
                                                                             }
                header.editButton.addTarget(self, action: #selector(touchEditButton(_:)), for: .touchUpInside)
                return header
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionView Delegate
extension HomeStartViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 225)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 42)
        case 2:
            switch homeStatus {
            case .beforeRainbow:
                return CGSize(width: collectionView.bounds.width, height: 182)
            default:
                return CGSize(width: collectionView.bounds.width, height: 241)
            }
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 71)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
