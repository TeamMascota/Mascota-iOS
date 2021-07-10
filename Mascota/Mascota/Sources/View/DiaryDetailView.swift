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
        
        imageScrollView.delegate = self
        textView.delegate = self
        setPageControl()
        setDiaryDetailView()
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
    
    public lazy var imageScrollView = UIScrollView().then {
        $0.alwaysBounceVertical = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
        $0.bounces = false
        $0.backgroundColor = .cyan
    }
    
    private lazy var imageContentView = UIView()
    
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
    
    public func setImageScrollView() {
        
        imageScrollView.addSubviews(imageContentView)
        
        imageContentView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.centerY.top.bottom.equalToSuperview()
        }
    
        imageScrollView.layoutIfNeeded()

        for i in 0..<images.count {
            let imageView = UIImageView(image: images[i])
            let xPos = imageScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height)
            imageScrollView.addSubview(imageView)
        }

        imageScrollView.contentSize = CGSize(width: imageScrollView.frame.width * CGFloat(images.count), height: imageScrollView.frame.height)
        
    }
    
    private func setDiaryDetailView() {
        addSubviews(dateLabel, togetherDayLabel, underLineView)
        
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

        addSubviews(imageScrollView, pageControl)

        imageScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(imageScrollView.snp.width).multipliedBy(0.8)
        }

        pageControl.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(7)
        }

        addSubviews(textView)
        
        textView.isScrollEnabled = false
        
        print(textView.contentSize.height)

        textView.sizeToFit()
        textView.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
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
        if textView.contentSize.height <= 190 {
            textView.snp.remakeConstraints {
                $0.top.equalTo(imageScrollView.snp.bottom).offset(34)
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
            imageScrollView.isHidden = true
            imageContentView.isHidden = true
        }
    }
}

extension DiaryDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setPageControlSelectedPage(currentPage: Int(round(scrollView.contentOffset.x / scrollView.frame.maxX)))
    }

    private func setPageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }

    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
}

extension DiaryDetailView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
