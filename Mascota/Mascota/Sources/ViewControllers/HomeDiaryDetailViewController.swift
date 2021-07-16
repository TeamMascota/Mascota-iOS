//
//  HomeDiaryDetailViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/12.
//

import UIKit

import Moya

class HomeDiaryDetailViewController: BaseViewController {
    
    private lazy var service = MoyaProvider<DiaryAPI>(plugins: [MoyaLoggingPlugin()])
    
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
        
        setNavigationBar()
        
        setScrollView()
        setTextView()
        
        contentView.setDate(date: "2020년 쏼라", togetherDay: "2223")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.textView.setUnderLine(color: .macoOrange)
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
        navigationItem.setTitle(title: "코봉이의 중성화 날", subtitle: "161화", titleColor: .macoBlack, subtitleColor: .macoDarkGray)
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
    
    private func setTextView() {
        contentView.setTextViewText(text: "하afj'oi audfldkfjak위dsa;aihf'od'ov하'ov하위dsa;aihf'odisafj'oi audfldkfjak위dsa;aihf'odisafj'oRㅁ야롱먀놀;ㅏㅇ몰;ㅏ\n\n\n\n\nㅇ뫃;daskfhadkjhf;kdsajhf;kㅏㅓㅗㅁㅇㄹ; ㅓㅈ'ㄷR ojuaef'oi hads;kfhdaksfhkadjhf;aldiur 'eu'oasdifk;dsajhfkdjhfjdahfgkjadflgkjdfhgkhfkjdhfkdsjhfkdjshfksdjhfasdfadfdsaf adf sadf sdsdhf ;ao ih'adoiy'owqy dhdksfhdksjh끝")
    }

}

extension HomeDiaryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

extension HomeDiaryDetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentView.setPageControlSelectedPage(currentPage: Int(round(scrollView.contentOffset.x / scrollView.frame.maxX)))
    }
    
}

extension HomeDiaryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentView.setPageControl(pageCount: images.count)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contentView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: DiaryDetailImageCollectionViewCell.identifier, for: indexPath)
                                                                        as? DiaryDetailImageCollectionViewCell
                                                                        else { return DiaryDetailImageCollectionViewCell() }
//        cell.setImage(image: images[indexPath.row])
        
        return cell
    }
    
}

extension HomeDiaryDetailViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension HomeDiaryDetailViewController {
    @objc
    func moveToEpisode(_ sender: UIButton) {
        print("moveToEpisode")
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


extension HomeDiaryDetailViewController {
    func requestGetPetDiary(diaryID: String) {
        self.attachIndicator(.normal)
        service.request(DiaryAPI.getPetDiary(diaryID: diaryID))  { [weak self] result in
            self?.detachIndicator()
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(GenericModel<GetPetDiaryModel>.self, from: response.data)
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
