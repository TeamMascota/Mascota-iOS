//
//  BaseDiaryDetailViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/09.
//

import UIKit

class BaseDiaryDetailViewController: UIViewController {
    
    public lazy var images: [UIImage] = [.add, .checkmark, .remove]
    
    public lazy var dateLabel = UILabel().then {
        $0.font = .macoFont(type: .regular, size: 14)
        $0.textColor = .macoDarkGray
        $0.text = "2021년 6월 18일"
    }
    
    public lazy var togetherDayLabel = UILabel().then {
        $0.font = .macoFont(type: .regular, size: 14)
        $0.textColor = .macoDarkGray
        $0.text = "함께한 지 1291일"
    }
    
    public lazy var gridImage = UIImageView()

    public lazy var emojiStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.backgroundColor = .blue
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var underLineView = UIView().then {
        $0.backgroundColor = .macoDarkGray
    }
    
    private lazy var imageScrollView = UIScrollView().then {
        $0.alwaysBounceVertical = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
        $0.bounces = false
        $0.backgroundColor = .cyan
    }
    
    private lazy var pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = UIColor.macoOrange.withAlphaComponent(0.3)
        $0.currentPageIndicatorTintColor = .macoOrange
        $0.isUserInteractionEnabled = false

    }
    
    private lazy var textView = UITextView().then {
        $0.setMacoTextView(color: .macoOrange)
    }
    
    private lazy var pageImageView = UIImageView()
    
    private lazy var beforeButton = UIButton()
    private lazy var afterButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseDiaryDetailViewController()
        
        imageScrollView.delegate = self
        setNavigationBar()
        setScrollView()
        setPageControl()
        setEmojiStackView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.setUnderLine(color: .macoOrange)
    }
    
    private func setNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoIvory, tintColor: .macoWhite, underLineColor: .macoDarkGray)
        navigationItem.setTitle(title: "코봉이의 중성화 날", subtitle: "161화", titleColor: .macoBlack, subtitleColor: .macoDarkGray)
//        navigationItem.leftBarButtonItem = backButton
//        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setScrollView() {
        
        imageScrollView.layoutIfNeeded()
    
        for i in 0..<images.count {
            let imageView = UIImageView(image: images[i])
            let xPos = imageScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height)
            imageScrollView.addSubview(imageView)
        }
        
        imageScrollView.contentSize = CGSize(width: imageScrollView.frame.width * 3, height: imageScrollView.frame.height)
    }
    
    private func setBaseDiaryDetailViewController() {
        view.addSubviews(dateLabel, togetherDayLabel, underLineView)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
        }
        
        togetherDayLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        view.addSubviews(imageScrollView, pageControl)
        
        imageScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(imageScrollView.snp.width).multipliedBy(343 / 300)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(7)
        }
        
        view.addSubviews(textView)
        
        textView.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(34)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setEmojiStackView() {
        
        emojiStackView.addArrangedSubviews(UIImageView(image: images[0]))
        
        view.addSubviews(emojiStackView)
        
        emojiStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(18)
            $0.top.equalTo(underLineView.snp.bottom).offset(15)
        }
    
    }

}

extension BaseDiaryDetailViewController {
    private func setPageControlSelectedPage(currentPage: Int) {
           pageControl.currentPage = currentPage
    }
    
    private func setPageControl() {
           pageControl.numberOfPages = images.count
    }
}

extension BaseDiaryDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setPageControlSelectedPage(currentPage: Int(round(scrollView.contentOffset.x / scrollView.frame.maxX)))

    }
}
