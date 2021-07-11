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
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    
    private lazy var gridImageView = UIImageView().then {
        $0.image = type.grid()
    }
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = .checkmark
    }

    public lazy var emojiStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 9
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
    
    public lazy var backwardButton = UIButton().then {
        switch type {
        case .home :
            $0.setImage(UIImage(named: "btnBackwardOrange"), for: .normal)
        case .rainbow:
            $0.setImage(UIImage(named: "btnBackwardBlue"), for: .normal)
        }
        $0.setImage(UIImage(named: "btnBackwardGray"), for: .disabled)
       
    }
    public lazy var forwardButton = UIButton().then {
        switch type {
        case .home :
            $0.setImage(UIImage(named: "btnForwardOrange"), for: .normal)
        case .rainbow:
            $0.setImage(UIImage(named: "btnForwardBlue"), for: .normal)
        }
        $0.setImage(UIImage(named: "btnForwardGray"), for: .disabled)
    }
    
    public lazy var textView = UITextView().then {
        $0.setMacoTextView(color: type.color())
    }
    
    public lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        
        $0.backgroundColor = .clear
        $0.collectionViewLayout = layout
    }

    public func setDiaryDetailView() {
        addSubviews(gridImageView, logoImageView, dateLabel, togetherDayLabel, underLineView, pageControl, imageCollectionView)
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(imageCollectionView.snp.width).multipliedBy(0.8)
        }
        
        logoImageView.snp.makeConstraints {
            $0.center.equalTo(imageCollectionView)
        }
        
        gridImageView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
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
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
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
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
        
        emojiStackView.addArrangedSubviews(UIImageView(image: UIImage(named: "emoDogAngry")))

        addSubviews(emojiStackView, forwardButton, backwardButton)

        emojiStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(32)
            $0.top.equalTo(underLineView.snp.bottom).offset(15)
        }
        
        forwardButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(emojiStackView.snp.centerY)
        }
        
        backwardButton.snp.makeConstraints {
            $0.centerY.equalTo(forwardButton.snp.centerY)
            $0.trailing.equalTo(forwardButton.snp.leading).offset(-17)
        }
    }
    
    public func setTextViewText(text: String) {
        textView.setText(text: text)
        textView.layoutIfNeeded()
        
        print(textView.contentSize.height)
        if textView.contentSize.height <= 190 && !UIDevice.current.hasNotch {
            textView.snp.remakeConstraints {
                $0.top.equalTo(imageCollectionView.snp.bottom).offset(34)
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(Constant.DeviceSize.height / Constant.DesignSize.height * 197)
                $0.bottom.equalToSuperview().inset(32)
            }
        } else if textView.contentSize.height <= 243 && UIDevice.current.hasNotch {
            textView.snp.remakeConstraints {
                $0.top.equalTo(imageCollectionView.snp.bottom).offset(34)
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(243)
                $0.bottom.equalToSuperview().inset(32)
            }
        }
    }
    
    public func setPageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }

    public func setPageControl(pageCount: Int) {
        pageControl.numberOfPages = pageCount
    }
    
    public func setDate(date: String, togetherDay: String) {
        dateLabel.text = date
        togetherDayLabel.attributedText = "함께한 지 \(togetherDay)일".convertSomeColorFont(color: type.color(),
                                                            
                                                                                                 type: .regular, start: 6,
                                                                                                 length: togetherDay.count)
    }
    
}

