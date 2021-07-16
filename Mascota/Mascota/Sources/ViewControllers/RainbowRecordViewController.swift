//
//  RainbowBookCoverViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

import Moya

class RainbowRecordViewController: UIViewController {
    private var petId: String?
    private lazy var service = MoyaProvider<RainbowAPI>(plugins: [MoyaLoggingPlugin()])
    private var rainbowRecordModel: GetRainbowRecordModel?
    private var delegate: RainbowBridgeDelegator?
    
    private lazy var nextButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("다음", for: .normal)
    }
    
    private lazy var diaryCountLabel = UILabel().then {
        $0.textColor = .macoWhite
        $0.font = .macoFont(type: .bold, size: 23)
    }
    
    private lazy var dayTogetherLabel = UILabel().then {
        $0.textColor = .macoWhite
    }
    
    private lazy var bookCoverView = BookCoverView()
    
    private lazy var backButton = UIBarButtonItem().then {
        $0.backBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapBackButton(_:)))
    }
    
    private lazy var closeButton = UIBarButtonItem().then {
        $0.closeBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapCloseButton(_:)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowBookCoverViewController()
        
        setAddTarget()
        layoutViewController()
        setBookCoverView()
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRainbowNavigationBar()
    }
    
    private func setAddTarget() {
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
    }
    
    private func initRainbowBookCoverViewController() {
        view.backgroundColor = .macoBlue
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoBlue, tintColor: .macoWhite, underLineColor: .macoWhite)
        navigationItem.setTitle(title: "무지개 다리")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setButton() {
        view.addSubviews(nextButton)
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
        }
    }
    
    private func layoutViewController() {
        view.addSubviews(diaryCountLabel, dayTogetherLabel)
        
        diaryCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
            $0.leading.equalToSuperview().offset(23)
        }
        
        dayTogetherLabel.snp.makeConstraints {
            $0.top.equalTo(diaryCountLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(23)
        }

        view.addSubviews(bookCoverView)
        
        if UIDevice.current.hasNotch {
            bookCoverView.snp.makeConstraints {
                $0.top.equalTo(dayTogetherLabel.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(28)
                $0.trailing.equalToSuperview().inset(28)
                $0.height.equalTo(bookCoverView.snp.width).multipliedBy(1.4)
            }
        } else {
            bookCoverView.snp.makeConstraints {
                $0.top.equalTo(dayTogetherLabel.snp.bottom).offset(20)
                $0.bottom.equalToSuperview().inset(111)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(bookCoverView.snp.height).multipliedBy(0.7)
            }
        }
        
    }
    
    private func setBookCoverView() {
        requestRainbowRecord(petId: petId) {
            let diaryAttr = NSMutableAttributedString()
            diaryAttr.append("지금까지 썼던 책은 ".convertColorFont(color: .macoWhite, fontSize: 20, type: .medium))
            
            guard let diaryCount = self.rainbowRecordModel?.diaryCount else { return }
            diaryAttr.append("총 \(diaryCount)화".convertColorFont(color: .macoWhite, fontSize: 20, type: .bold))

            self.diaryCountLabel.attributedText = diaryAttr

            let dayTogetherAttr = NSMutableAttributedString()
            dayTogetherAttr.append("함께 보낸 날은 총 ".convertColorFont(color: .macoWhite, fontSize: 20, type: .medium))
            
            guard let dayTogether = self.rainbowRecordModel?.dayTogether else { return }
            dayTogetherAttr.append("총 \(dayTogether)일".convertColorFont(color: .macoWhite, fontSize: 20, type: .bold))
            self.dayTogetherLabel.attributedText = dayTogetherAttr
            
            guard let bookTitle = self.rainbowRecordModel?.bookInfo.title else { return }
            guard let bookAuthor = self.rainbowRecordModel?.bookInfo.author else { return }
            self.bookCoverView.setTitleAndWriterLabel(title: bookTitle, author: "작가 \(bookAuthor)")
            
            guard let bookCover = self.rainbowRecordModel?.bookInfo.bookImg else { return }
            self.bookCoverView.setBookCoverImage(cover: bookCover)
        }
    }
    
}

extension RainbowRecordViewController {
    
    @objc
    func tapBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func tapCloseButton(_ sender: UIBarButtonItem) {
        let customLabelAlertView = CustomLabelAlertView()
        
        customLabelAlertView.setAttributedTitle(attributedText: "이별의 단계".attributedString(font: .macoFont(type: .bold, size: 17), color: .macoBlack, customLineHeight: 18, alignment: .center))
        
        customLabelAlertView.setAttributedDescription(attributedText: "이별의 단계가 초기화됩니다.\n무지개 다리를 나가시겠어요?"
                                                    .attributedString(font: .macoFont(type: .regular, size: 13), color: .macoBlack, customLineHeight: 25, alignment: .center))

        self.presentDoubleCustomAlert(view: customLabelAlertView,
                                      preferredSize: CGSize(width: 270, height: 130),
                                      firstHandler: { _ in
                                      },
                                      secondHandler: {  _ in
                                        self.requesttCancelRainbowBridge(petId: self.petId) {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                      },
                                      firstText: "취소", secondText: "나가기", color: .macoBlue)
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        let rainbowMomentViewController = RainbowMomentViewController()
        self.delegate = rainbowMomentViewController
        if let petId = petId {
            self.delegate?.setPetId(petId: petId)
        }
        navigationController?.pushViewController(rainbowMomentViewController, animated: true)
    }
    
}
extension RainbowRecordViewController: RainbowBridgeDelegator {
    func setPetId(petId: String) {
        self.petId = petId
    }
    
}
extension RainbowRecordViewController {
    func requesttCancelRainbowBridge(petId: String?, completion: @escaping () -> Void ) {
        guard let petId = petId else { return }
        service.request(RainbowAPI.deleteRainbowBridge(petId: petId)) { [weak self] result in
            guard self != nil else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    _ = try JSONDecoder().decode(GenericModel<PutPartingRainbowBridgeModel>.self, from: response.data)
                    completion()
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestRainbowRecord(petId: String?, completion: @escaping () -> Void ) {
        guard let petId = petId else { return }
        service.request(RainbowAPI.getRainbowRecord(petId: petId)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(GenericModel<GetRainbowRecordModel>.self, from: response.data)
                    self.rainbowRecordModel = response.data
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
