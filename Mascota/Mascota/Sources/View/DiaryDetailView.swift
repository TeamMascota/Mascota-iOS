//
//  DiaryDetailView.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/10.
//

import UIKit

class DiaryDetailView: UIView {
    private var type: BookType = .home
    
    public init(type: BookType) {
        super.init(frame: CGRect.zero)
        self.type = type

        imageCollectionView.register(DiaryDetailImageCollectionViewCell.self, forCellWithReuseIdentifier: DiaryDetailImageCollectionViewCell.identifier)
        
//        setDiaryDetailView()
//        setPageControl()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public lazy var images = [UIImage]()
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
    
    public lazy var gridImageView = UIImageView().then {
        $0.image = UIImage(named: "bgDiarygridOrange")
    }

    public lazy var emojiStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.backgroundColor = .blue
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var underLineView = UIView().then {
        $0.backgroundColor = .macoDarkGray
    }
    
    public lazy var pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = type.color().withAlphaComponent(0.3)
        $0.currentPageIndicatorTintColor = type.color()
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var beforeButton = UIButton()
    private lazy var afterButton = UIButton()
    
    public lazy var textView = UITextView().then {
        $0.setMacoTextView(color: type.color())
    }
    
    public lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
        
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.isPagingEnabled = true
        $0.collectionViewLayout = layout
    }

    public func setDiaryDetailView() {
        addSubviews(gridImageView, dateLabel, togetherDayLabel, underLineView, pageControl, imageCollectionView)
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(Constant.DeviceSize.width - 16)
//            $0.height.equalTo(imageCollectionView.snp.width).multipliedBy(0.8)
            $0.leading.equalToSuperview().offset(16).labeled("-------imageCollectionView leading-----")
            $0.trailing.equalToSuperview().inset(16).labeled("-------imageCollectionView leading-----")
            $0.height.equalTo(imageCollectionView.snp.width).multipliedBy(0.8).labeled("------imageCollectionView height------")
        }
        
        gridImageView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom)
            $0.leading.equalToSuperview().offset(16).labeled("-------gridImageView leading-----")
            $0.trailing.equalToSuperview().inset(16).labeled("-------gridImageView trailing-----")
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.top.equalToSuperview().offset(9)
        }

        togetherDayLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.top.equalToSuperview().offset(9)
        }

        underLineView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40).labeled("💙underLineView💙")
            $0.leading.equalToSuperview().offset(16).labeled("💙underLineView💙")
            $0.trailing.equalToSuperview().inset(16).labeled("💙underLineView💙")
            $0.height.equalTo(1).labeled("💙underLineView💙")
        }

        pageControl.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(7)
        }

        addSubviews(textView)
        
        textView.isScrollEnabled = false
        
        print(textView.contentSize.height)

        textView.sizeToFit()
        textView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(34).labeled("💙textView💙")
            $0.leading.equalToSuperview().offset(16).labeled("💙textView💙")
            $0.trailing.equalToSuperview().inset(16).labeled("💙textView💙")
            $0.bottom.equalToSuperview().inset(32).labeled("💙textView💙")
        }
        
        emojiStackView.addArrangedSubviews(UIImageView(image: UIImage.add))

        addSubviews(emojiStackView)

        emojiStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(18)
            $0.top.equalTo(underLineView.snp.bottom).offset(15)
        }
    }
    
    public func setTextViewText(text: String) {
        textView.setText(text: text)
        print(textView.contentSize.height)
        if textView.contentSize.height <= 190 {
            textView.snp.remakeConstraints {
                $0.top.equalTo(imageCollectionView.snp.bottom).offset(34)
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(Constant.DeviceSize.height / Constant.DesignSize.height * 209)
                $0.bottom.equalToSuperview().inset(32)
            }
        }
    }
    
    public func setImages(images: [UIImage]? = nil) {
        if let images = images {
            self.images = images
            setPageControl()
        } else {
            imageCollectionView.isHidden = true
        }
    }
}

extension DiaryDetailView {
    public func setPageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }

    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
}
