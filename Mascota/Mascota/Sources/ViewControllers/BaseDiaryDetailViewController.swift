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
        
        setNavigationBar()
        
        setImages()
        setScrollView()
        setTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.setImageScrollView()
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
        
        mainScrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }

    }
    
    private func setTextView() {
        contentView.setTextViewText(text: "하위dsa;aihf'odisafj'oi audfldkfjakldfjdlaskjfklasd")
    }
    
    private func setImages() {
//        contentView.setImages(images: images)
    }

}
