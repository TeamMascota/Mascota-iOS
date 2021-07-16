//
//  RainbowMomentViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import Moya

class RainbowMomentViewController: UIViewController {
    
    private lazy var service = MoyaProvider<RainbowAPI>(plugins: [MoyaLoggingPlugin()])
    private var rainbowMomentModel: GetRainbowMomentModel?
    private var delegate: RainbowDiaryDetailViewDelegator?
    private var petId: String?
    private var diariesID: [String?] = []
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var nextButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("다음", for: .normal)
        $0.addTarget(self, action: #selector(tapNextButton(_:)), for: .touchUpInside)
    }
    
    private lazy var backButton = UIBarButtonItem().then {
        $0.backBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapBackButton(_:)))
    }
    private lazy var closeButton = UIBarButtonItem().then {
        $0.closeBarButtonItem(color: .macoWhite, style: .plain, target: self, action: #selector(tapCloseButton(_:)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowBestViewController()
       
        setTableView()
        setButton()
        
        registerTableViewCell()
        requestGetRainMoment(petId: petId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRainbowNavigationBar()
    }

    private func initRainbowBestViewController() {
        view.backgroundColor = .macoBlue
    }
    
    private func setRainbowNavigationBar() {
        navigationController?.setMacoNavigationBar(barTintColor: .macoBlue, tintColor: .macoWhite, underLineColor: .macoWhite)
        navigationItem.setTitle(title: "최고의 순간")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setTableView() {
        view.addSubviews(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(55)
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
    
    private func registerTableViewCell() {
        tableView.register(RainbowBookPageTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowBookPage)
    }
        
}

extension RainbowMomentViewController {
    @objc
    func tapBackButton(_ sender: UIBarItem) {
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
                                        self.requsetCancelRainbowBridge(petId: self.petId) {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                      },
                                      firstText: "취소", secondText: "나가기", color: .macoBlue)
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        navigationController?.pushViewController(RainbowEpillogueViewController(), animated: true)
    }
}

extension RainbowMomentViewController: UITableViewDelegate {

}

extension RainbowMomentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = rainbowMomentModel?.theBestMoments.count {
            return sections
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 5:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if rainbowMomentModel?.theBestMoments[section].diaries != nil {
            let header = RainbowBestSectionHeaderView()
            if let comment = rainbowMomentModel?.theBestMoments[section].comment,
               let feelingCode = rainbowMomentModel?.theBestMoments[section].feeling,
               let kind = rainbowMomentModel?.pet.kind,
               let emoji = EmojiStyle().getEmoji(kind: kind, feeling: feelingCode) {
                    let feeling = EmojiStyle().getEmojiText(kind: kind, feeling: feelingCode)
                    header.setHeaderView(title: feeling, text: comment, image: emoji)
            }
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 5:
            return RainbowBestSectionFooterView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRowsInSection = rainbowMomentModel?.theBestMoments[section].diaries?.count {
            return (numberOfRowsInSection + 1) % 2
            return numberOfRowsInSection / 2
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowBookPage, for: indexPath) as? RainbowBookPageTableViewCell
        else { return UITableViewCell() }
        let leftPage = rainbowMomentModel?.theBestMoments[indexPath.section].diaries?[2 * indexPath.row]
        let rightPage = rainbowMomentModel?.theBestMoments[indexPath.section].diaries?[2 * indexPath.row + 1]
        
        diariesID.append(leftPage?.diaryId ?? nil)
        diariesID.append(rightPage?.diaryId ?? nil)
        
        if let feelingCode = rainbowMomentModel?.theBestMoments[indexPath.section].feeling,
           let kind = rainbowMomentModel?.pet.kind,
           let emoji = EmojiStyle().getEmoji(kind: kind, feeling: feelingCode) {
            cell.bookPageView.leftPageView.faceImageView.image = emoji
            cell.bookPageView.rightPageView.faceImageView.image = emoji
          }
        cell.setContentText(pages: [leftPage, rightPage])
  
        cell.selectionStyle = .none
        cell.bookPageView.leftPageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBookPage(_:))))
        cell.bookPageView.rightPageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBookPage(_:))))
        
        var leftTag = 2 * indexPath.row
        var rightTag = 2 * indexPath.row + 1
        
        for i in 0..<indexPath.section {
            if i != 0 {
                if let diaries = rainbowMomentModel?.theBestMoments[i - 1].diaries {
                    leftTag += diaries.count
                    rightTag += diaries.count
                }
            }
        }
        
        cell.bookPageView.leftPageView.tag = leftTag
        cell.bookPageView.rightPageView.tag = rightTag

        return cell
    }
    
    @objc
    func tapBookPage(_ sender: UITapGestureRecognizer) {
        let vc = RainbowDiaryDetailViewController()
        self.delegate = vc
        if let view = sender.view ,
           let id = diariesID[view.tag] {
            self.delegate?.sendingDiaryId(id: id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension RainbowMomentViewController {
    func requestGetRainMoment(petId: String?) {
        let userId = APIService.userID
        guard let petId = petId else { return }
        service.request(RainbowAPI.getRainbowMoment(userId: userId, petId: petId)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(GenericModel<GetRainbowMomentModel>.self, from: response.data)
                    self.rainbowMomentModel = response.data
                    self.tableView.reloadData()
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

extension RainbowMomentViewController: RainbowBridgeDelegator {
    func setPetId(petId: String) {
        self.petId = petId
    }
}
