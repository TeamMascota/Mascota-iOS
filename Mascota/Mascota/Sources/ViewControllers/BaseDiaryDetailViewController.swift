//
//  BaseDiaryDetailViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/09.
//

import UIKit

class BaseDiaryDetailViewController: UIViewController {
    
    public lazy var images: [UIImage] = [.add, .checkmark, .remove]
    
    private lazy var contentView = DiaryDetailView(type: .rainbow)
    
    private lazy var mainScrollView = UIScrollView().then {
        $0.alwaysBounceHorizontal = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.bounces = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.imageCollectionView.delegate = self
        contentView.imageCollectionView.dataSource = self
        contentView.textView.delegate = self
        
        setNavigationBar()
        
        setImages()
        setScrollView()
        setTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.textView.setUnderLine(color: .macoBlue)
    }
    
    private func setNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoIvory, tintColor: .macoWhite, underLineColor: .macoDarkGray)
        navigationItem.setTitle(title: "코봉이의 중성화 날", subtitle: "161화", titleColor: .macoBlack, subtitleColor: .macoDarkGray)
//        navigationItem.leftBarButtonItem = backButton
//        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setScrollView() {
        view.addSubviews(mainScrollView)

        mainScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        mainScrollView.addSubviews(contentView)
      
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.setDiaryDetailView()
        
//        contentView.layoutIfNeeded()
    }
    
    private func setTextView() {
        contentView.setTextViewText(text: "하위dsa;aihf'odisafj'oi audfldkfjak위dsa;aihf'odisafj'oi audftSize.height")
    }
    
    private func setImages() {
        contentView.setImages(images: images)
    }

}

extension BaseDiaryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

extension BaseDiaryDetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentView.setPageControlSelectedPage(currentPage: Int(round(scrollView.contentOffset.x / scrollView.frame.maxX)))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension BaseDiaryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contentView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: DiaryDetailImageCollectionViewCell.identifier, for: indexPath)
                                                                        as? DiaryDetailImageCollectionViewCell
                                                                        else { return DiaryDetailImageCollectionViewCell() }
        cell.setData(title: "응애")
        
        return cell
    }
    
}

extension BaseDiaryDetailViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
