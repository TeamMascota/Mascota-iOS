//
//  RainbowViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/01.
//

import UIKit

import SnapKit
import Moya
import Then

class RainbowViewController: UIViewController {
    private var rainbowBridgeDelegate: RainbowBridgeDelegator?
    private var rainbowDiaryDetailDelegate: RainbowDiaryDetailViewDelegator?
    
    private lazy var mainNavigationBar = MainNavigationBarView(type: .rainbow)
    private lazy var service = MoyaProvider<RainbowAPI>(plugins: [MoyaLoggingPlugin()])
    
    private var rainbowPageModel: RainbowMainPageModel?
    private var rainbowPetModel: [RainbowPetInfoModel]?
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var petId: String = "가나다라"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowViewController()
        setMainNavigationBar()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        getRainbowHome()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func initRainbowViewController() {
        view.backgroundColor = .macoIvory
    }
    
    private func setMainNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(mainNavigationBar)
        
        mainNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topBarHeight)
        }
        
        mainNavigationBar.setNavigationBarText(title: "무지개 다리 준비하기")
    }
    
    private func setTableView() {
        registerTableViewCell()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubviews(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalTo(mainNavigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func registerTableViewCell() {
        tableView.register(RainbowBookPageTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowBookPage)
        tableView.register(RainbowHelpHeaderTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowHelpHeader)
        tableView.register(RainbowHelpCardTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowHelpCard)
        tableView.register(RainbowButtonTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowButton)
    }
    
}

extension RainbowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension RainbowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return rainbowPageModel?.help.count ?? 0
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowBookPage, for: indexPath) as? RainbowBookPageTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.bookPageView.leftPageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLeftBookPage(_:))))
            cell.bookPageView.rightPageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapRightBookPage(_:))))
            
            if let memories = rainbowPageModel?.memories {
                cell.setContentText(pages: memories)
                if let leftFeeling = memories[0]?.feeling,
                   let rightFeeling = memories[1]?.feeling {
                    let kind = 1
                        cell.bookPageView.leftPageView.faceImageView.image = EmojiStyle().getEmoji(kind: kind, feeling: leftFeeling)
                        cell.bookPageView.rightPageView.faceImageView.image = EmojiStyle().getEmoji(kind: kind, feeling: rightFeeling)
                }
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowHelpHeader, for: indexPath) as? RainbowHelpHeaderTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.helpButton.addTarget(self, action: #selector(tapHelpButton(_:)), for: .touchUpInside)
            return cell
        
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowHelpCard, for: indexPath) as? RainbowHelpCardTableViewCell
            else { return UITableViewCell() }
            if let help = rainbowPageModel?.help[indexPath.row] {
                cell.setCardText(kind: help.classification, text: help.title)
            }
            cell.helpCardButton.tag = indexPath.row
            cell.helpCardButton.addTarget(self, action: #selector(tapHelpCardView(_:)), for: .touchUpInside)
            return cell
        
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowButton, for: indexPath) as? RainbowButtonTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            if let rainbowCheck = rainbowPageModel?.rainbowCheck {
                if rainbowCheck {
                    cell.button.isHidden = true
                } else {
                    cell.button.isHidden = false
                    cell.button.addTarget(self, action: #selector(tapNextButton(_:)), for: .touchUpInside)
                }
            }
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    @objc
    func tapHelpCardView(_ sender: UIButton) {
        if let helpCardURL = rainbowPageModel?.help[sender.tag].url {
            if let url = URL(string: helpCardURL) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @objc
    func tapHelpButton(_ sender: UIButton) {
        let helpCardAlertView = CustomLabelAlertView()
        
        helpCardAlertView.setAttributedTitle(attributedText: "도움글에 대해".attributedString(font: .macoFont(type: .bold, size: 17), color: .macoBlack, customLineHeight: 18, alignment: .center))
        
        helpCardAlertView.setAttributedDescription(attributedText: "지금은 먼 훗날의 일이라고 생각될 수 있지만,\n언젠가 다가올 이별을 위해 정리했어요.\n이별의 과정이 후회로만 기억되지 않도록\n도움글을 읽으며 마음을 천천히 준비해 보세요."
                                                    .attributedString(font: .macoFont(type: .regular, size: 13), color: .macoBlack, customLineHeight: 25, alignment: .center))
        
        self.presentSingleCustomAlert(view: helpCardAlertView, preferredSize: CGSize(width: 270, height: 190), confirmHandler: nil, text: "닫기", color: .macoBlue)
    }
    
    @objc
    func tapLeftBookPage(_ sender: UITapGestureRecognizer) {
        if let diaryId = rainbowPageModel?.memories[0]?.diaryId {
            let vc = RainbowDiaryDetailViewController()
            self.rainbowDiaryDetailDelegate = vc
            rainbowDiaryDetailDelegate?.sendingDiaryId(id: diaryId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    func tapRightBookPage(_ sender: UITapGestureRecognizer) {
        if let diaryId = rainbowPageModel?.memories[1]?.diaryId {
            let vc = RainbowDiaryDetailViewController()
            self.rainbowDiaryDetailDelegate = vc
            rainbowDiaryDetailDelegate?.sendingDiaryId(id: diaryId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        getRainbowPet { petModels in
            let petCustomView = CustomCollectionAlertView()
            petCustomView.setPetProfileStackView(pets: petModels)
        
            self.presentDoubleCustomAlert(view: petCustomView, preferredSize: CGSize(width: 270, height: 250), firstHandler: { _ in
            }, secondHandler: { _ in
                if petCustomView.selectedPetId != "" {
                    let viewcontroller = RainbowBridgeViewController()
                    self.rainbowBridgeDelegate = viewcontroller
                    
                    if let selectedPetId = petCustomView.selectedPetId {
                        self.rainbowBridgeDelegate?.setPetId(petId: selectedPetId)
                    }
                    
                    let rootNC = UINavigationController(rootViewController: viewcontroller)
                    rootNC.modalPresentationStyle = .fullScreen
                    self.present(rootNC, animated: true, completion: nil)
                }
            }, firstText: "취소", secondText: "다음", color: .macoBlue)
        }
    }
}

extension RainbowViewController {
    func getRainbowHome() {
        let petID = "60edf6e5e5003a744892ce39"
            service.request(RainbowAPI.getRainbowHome(userId: APIService.userID, petId: petID)) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let response):
                    do {
                        let response = try JSONDecoder().decode(GenericModel<GetRainbowHomeModel>.self, from: response.data)
                        self.rainbowPageModel = response.data?.rainbowMainPage
                        guard let bookImg = self.rainbowPageModel?.bookImg else { return }
                        self.mainNavigationBar.setNavigationBarButtonImage(url: bookImg)
                    
                        guard let title = self.rainbowPageModel?.title else { return }
                        self.mainNavigationBar.setNavigationBarText(title: title)
                            
                        self.tableView.reloadData()
                    } catch let err {
                        print(err.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
    
            }
    }
    
    func getRainbowPet(completion: @escaping ([RainbowPetInfoModel]) -> Void) {
        service.request(RainbowAPI.getRainbowPet) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(GenericModel<GetRainbowPetModel>.self, from: response.data)
                    guard let petModel = response.data?.pet
                    else { return }
                    completion(petModel)
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
