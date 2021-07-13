//
//  RainbowViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/01.
//

import UIKit

import SnapKit
import Then

class RainbowViewController: UIViewController {
    
    lazy var mainNavigationBar = MainNavigationBarView(type: .rainbow)
    
    let model = [HelpCardModel(kind: "[어쩌구]", text: "한줄일때 솰랴솰라뫄뫄뫄뫄마ㅗ뫄뫄"),
                 HelpCardModel(kind: "[어쩌구저쩌구]", text: "두줄일떄 불라불라뫄뫄모모마맘마 헤헤헤헤헤헤헤"),
                 HelpCardModel(kind: "[어쩌구]", text: "한줄일때 솰랴솰라뫄뫄뫄뫄마ㅗ뫄뫄"),
                 HelpCardModel(kind: "[어쩌구저쩌구]", text: "두줄일떄 불라불라뫄뫄모모마맘마 헤헤헤헤헤헤헤"),
                 HelpCardModel(kind: "[어쩌구]", text: "한줄일때 솰랴솰라뫄뫄뫄뫄마ㅗ뫄뫄"),
                 HelpCardModel(kind: "[어쩌구저쩌구]", text: "두줄일떄 불라불라뫄뫄모모마맘마 헤헤헤헤헤헤헤"),
                 HelpCardModel(kind: "[어쩌구저쩌구]", text: "두줄일떄 불라불라뫄뫄모모마맘마 헤헤헤헤헤헤헤"),
                 HelpCardModel(kind: "[어쩌구저쩌구]", text: "사실세줄도됨ㅋㅋㅋㅋ아 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ사실세줄도됨ㅋㅋㅋㅋ아 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")]
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
            return model.count
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
            cell.bookPageView.setContentText(pages: [PageTextModel(title: "dd", subtitle: "dd", content: "dd", date: "dd"),PageTextModel(title: "dd", subtitle: "dd", content: "dd", date: "dd")])
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowHelpHeader, for: indexPath) as? RainbowHelpHeaderTableViewCell
            else { return UITableViewCell() }
            cell.helpButton.addTarget(self, action: #selector(tapHelpButton(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowHelpCard, for: indexPath) as? RainbowHelpCardTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setCardText(kind: model[indexPath.row].kind, text: model[indexPath.row].text)
            return cell
        
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowButton, for: indexPath) as? RainbowButtonTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.button.addTarget(self, action: #selector(tapNextButton(_:)), for: .touchUpInside)
            return cell
            
        default:
            return UITableViewCell()
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
        let vc = RainbowDiaryDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func tapRightBookPage(_ sender: UITapGestureRecognizer) {
        navigationController?.pushViewController(RainbowDiaryDetailViewController(), animated: true)
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        let petCustomView = CustomCollectionAlertView()
        self.presentDoubleCustomAlert(view: petCustomView, preferredSize: CGSize(width: 270, height: 250), firstHandler: { _ in
        }, secondHandler: { _ in
            if petCustomView.petId != "" {
                let viewcontroller = RainbowCommentViewController()
                let rootNC = UINavigationController(rootViewController: viewcontroller)
                rootNC.modalPresentationStyle = .fullScreen
                self.present(rootNC, animated: true, completion: nil)
            }
        }, firstText: "취소", secondText: "다음", color: .macoBlue)
    }
}

struct HelpCardModel {
    let kind: String
    let text: String
}
