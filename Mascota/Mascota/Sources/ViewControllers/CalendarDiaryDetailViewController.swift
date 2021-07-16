//
//  CalendarDiaryDetailViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/16.
//

import UIKit

import Moya

protocol CalendarDiaryDetailDelegator {
    func sendingDiariesId(id: [String]?)
}

class CalendarDiaryDetailViewController: BaseViewController {
    
    private lazy var service = MoyaProvider<DiaryAPI>(plugins: [MoyaLoggingPlugin()])
    private var diaries: [PetDiaryModel] = []
    private var diariesId: [String]?
    
    private var nowDiaryIndex: Int = -1
    
    public lazy var images: [UIImage] = [.add, .checkmark, .remove]
    
    private lazy var contentView = DiaryDetailView(type: .home)
    
    private lazy var mainScrollView = UIScrollView().then {
        $0.alwaysBounceHorizontal = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.bounces = false
    }
    
    private lazy var backButton = UIBarButtonItem().then {
        $0.backBarButtonItem(style: .plain, target: self, action: #selector(tapBackButton(_:)))
    }
    private lazy var closeButton = UIBarButtonItem().then {
        $0.textBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(tapCloseButton(_:)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerContentView()
        initDiary(completion: {
            self.contentView.backwardButton.isEnabled = false
            if self.diaries.count == 1 {
                self.contentView.forwardButton.isEnabled = false
                self.contentView.setEmoji(feelingLists: self.diaries[0].feelingList)
            } else {
                self.contentView.forwardButton.isEnabled = true
            }
        })
        setNavigationBar()
        setScrollView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func registerContentView() {
        contentView.imageCollectionView.delegate = self
        contentView.imageCollectionView.dataSource = self
        contentView.textView.delegate = self
        
        contentView.backwardButton.addTarget(self, action: #selector(moveToEpisode(_:)), for: .touchUpInside)
        contentView.forwardButton.addTarget(self, action: #selector(moveToEpisode(_:)), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoIvory, tintColor: .macoWhite, underLineColor: .macoDarkGray)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
        
        view.backgroundColor = .macoIvory
    }
    
    private func setScrollView() {
        view.addSubviews(mainScrollView)

        mainScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainScrollView.addSubviews(contentView)
      
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.setDiaryDetailView()
    }
    
    private func initDiary(completion: @escaping() -> Void) {
            if let diariesId = self.diariesId {
                for diaryId in diariesId {
                    self.requestGetPetDiary(diaryID: diaryId, completion: {
                        self.nowDiaryIndex = 0
                        self.setDiaryView(index: self.nowDiaryIndex)
                        completion()
                    })
                }
                
            }
    }
    
    private func setDiaryView(index: Int) {
        navigationItem.setTitle(title: diaries[index].title, subtitle: "\(diaries[index].episode)화", titleColor: .macoBlack, subtitleColor: .macoDarkGray)
        contentView.setDate(date: diaries[index].date, togetherDay: "\(diaries[index].timeTogether)")
        contentView.setTextViewText(text: diaries[index].contents)
        
        self.contentView.backwardButton.isEnabled = true
        self.contentView.forwardButton.isEnabled = true
        
        switch index {
        case 0:
            contentView.backwardButton.isEnabled = false
        case diaries.count - 1:
            contentView.forwardButton.isEnabled = false
        default:
            break
        }
        self.nowDiaryIndex = index
        
        contentView.imageCollectionView.reloadData()
    }

}

extension CalendarDiaryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

extension CalendarDiaryDetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentView.setPageControlSelectedPage(currentPage: Int(round(scrollView.contentOffset.x / scrollView.frame.maxX)))
    }
    
}

extension CalendarDiaryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if nowDiaryIndex != -1 {
            contentView.setPageControl(pageCount: diaries[nowDiaryIndex].bookImg.count)
            return diaries[nowDiaryIndex].bookImg.count
        } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contentView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: DiaryDetailImageCollectionViewCell.identifier, for: indexPath)
                                                                        as? DiaryDetailImageCollectionViewCell
                                                                        else { return DiaryDetailImageCollectionViewCell() }
        if nowDiaryIndex != -1 {
            cell.setImage(url: diaries[nowDiaryIndex].bookImg[indexPath.row])
        }
        
        return cell
    }
    
}

extension CalendarDiaryDetailViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension CalendarDiaryDetailViewController {
    @objc
    func moveToEpisode(_ sender: UIButton) {
        switch sender {
        case contentView.backwardButton:
            if nowDiaryIndex != 0 {
                nowDiaryIndex -= 1
                setDiaryView(index: nowDiaryIndex)
            }
        case contentView.forwardButton:
            if nowDiaryIndex != diaries.count - 1 {
                nowDiaryIndex += +1
                setDiaryView(index: nowDiaryIndex)
            }
        default:
            break
        }
    }

    @objc
    func tapBackButton(_ sender: UIBarButtonItem) {
        print("click")
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func tapCloseButton(_ sender: UIBarButtonItem) {
        print("click")
    }
}

extension CalendarDiaryDetailViewController {
    func requestGetPetDiary(diaryID: String?, completion: @escaping() -> Void) {
        guard let diaryID = diaryID
        else { return }
        self.attachIndicator(.normal)
        service.request(DiaryAPI.getPetDiary(diaryID: diaryID)) { [weak self] result in
            self?.detachIndicator()
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(GenericModel<GetPetDiaryModel>.self, from: response.data)
                    guard let petDiary = response.data?.petDiary else { return }
                    self.diaries.append(petDiary)
                    self.nowDiaryIndex = 0
                    completion()
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CalendarDiaryDetailViewController: CalendarDiaryDetailDelegator {
    func sendingDiariesId(id: [String]?) {
        self.diariesId = id
    }
}
