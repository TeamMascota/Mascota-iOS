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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRainbowViewController()
        setMainNavigationBar()
        setTableView()
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
        
        view.addSubviews(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalTo(mainNavigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func registerTableViewCell() {
        tableView.register(RainbowBookPageTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowBookPage)
        tableView.register(RainbowHelpHeaderTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowHelpHeader)
        tableView.register(RainbowHelpCardTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowHelpCard)
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
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowBookPage, for: indexPath) as? RainbowBookPageTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowHelpHeader, for: indexPath) as? RainbowHelpHeaderTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowHelpCard, for: indexPath) as? RainbowHelpCardTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setCardText(kind: model[indexPath.row].kind, text: model[indexPath.row].text)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}

struct HelpCardModel{
    let kind: String
    let text: String
}
