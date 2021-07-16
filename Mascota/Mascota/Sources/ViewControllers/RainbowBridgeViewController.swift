//
//  RainbowBridgeViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

import Moya

protocol RainbowBridgeDelegator {
    func setPetId(petId: String)
}

class RainbowBridgeViewController: UIViewController {

    private lazy var service = MoyaProvider<RainbowAPI>(plugins: [MoyaLoggingPlugin()])
    private var partingRainbowBridgeModel: PartingRainbowBridgeModel?
    
    private var delegate: RainbowBridgeDelegator?
    private var petId: String?
    
    private lazy var contentLabel = UILabel().then {
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.font = .macoFont(type: .medium, size: 16)
        $0.textColor = .macoWhite
    }
    
    private lazy var macoImageView = UIImageView().then {
        $0.image = UIImage(named: "illustRainbowCatBig")
    }
    
    private lazy var nextButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("다음", for: .normal)
        $0.addTarget(self, action: #selector(tapNextButton(_:)), for: .touchUpInside)
    }
    
    private lazy var closeButton = UIBarButtonItem().then {
        $0.closeBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapCloseButton(_:)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initRainbowCommentViewController()
        
        setImageVIew()
        setButton()
        setContentLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRainbowNavigationBar()
    }
    
    private func initRainbowCommentViewController() {
        view.backgroundColor = .macoBlue
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoBlue, tintColor: .macoWhite, underLineColor: .macoWhite)
        navigationItem.setTitle(title: "무지개 다리")
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setImageVIew() {
        view.addSubviews(macoImageView)
        
        macoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.DeviceSize.width)
            $0.bottom.equalToSuperview().inset(133)
        }
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
    
    private func setContentLabel() {
        requestRainbowBridgeContents(petId: petId) {
            self.contentLabel.alpha = 0.0
            self.contentLabel.attributedText = self.partingRainbowBridgeModel?.contents.attributedString(font: .macoFont(type: .medium, size: 16), color: .macoWhite, customLineHeight: 28)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) {
                self.contentLabel.alpha = 1.0
            }
        }
        
        view.addSubviews(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
            $0.leading.equalToSuperview().offset(23)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
}

extension RainbowBridgeViewController {
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
                                        self.requsetCancelRainbowBridge(petId: self.petId) {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                      },
                                      firstText: "취소", secondText: "나가기", color: .macoBlue)
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        let rainbowRecordViewController = RainbowRecordViewController()
        self.delegate = rainbowRecordViewController
        if let petId = petId {
            self.delegate?.setPetId(petId: petId)
        }
        navigationController?.pushViewController(rainbowRecordViewController, animated: true)
    }
}

extension RainbowBridgeViewController: RainbowBridgeDelegator {
    func setPetId(petId: String) {
        self.petId = petId
    }
}

extension RainbowBridgeViewController {
    func requestRainbowBridgeContents(petId: String?, completion: @escaping () -> Void) {
        guard let petId = petId else { return }
        service.request(RainbowAPI.putRainbowBridge(petId: petId)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(GenericModel<PutPartingRainbowBridgeModel>.self, from: response.data)
                    self.partingRainbowBridgeModel = response.data?.partingRainbowBridge
                    completion()
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requsetCancelRainbowBridge(petId: String?, completion: @escaping () -> Void) {
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
}
