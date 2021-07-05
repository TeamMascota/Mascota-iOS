//
//  RainbowBestViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

class RainbowBestViewController: UIViewController {
    
    private lazy var rainbowNavigationBar = RainbowNavigationBarView(style: .leftAndRight, title: "최고의 순간")
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        
    }
    
    private lazy var nextButton = MacoButton(color: .white).then {
        $0.setMacoButtonTitle("다음", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRainbowBestViewController()
        
        setMainNavigationBar()
        setTableView()
        setAddTarget()
        setButton()
        
        registerTableViewCell()
    }
    
    private func initRainbowBestViewController() {
        view.backgroundColor = .macoBlue
    }
    
    private func setMainNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubviews(rainbowNavigationBar)
        
        rainbowNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topBarHeight)
        }
    }
    
    private func setTableView() {
        view.addSubviews(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(rainbowNavigationBar.snp.bottom)
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
    
    private func setAddTarget() {
        rainbowNavigationBar.backButton.addTarget(self, action: #selector(tapBackButton(_:)), for: .touchUpInside)
        rainbowNavigationBar.closeButton.addTarget(self, action: #selector(tapCloseButton(_:)), for: .touchUpInside)
    }
    
    private func registerTableViewCell() {
        tableView.register(RainbowBookPageTableViewCell.self, forCellReuseIdentifier: AppConstants.TableCells.rainbowBookPage)
    }
        
}

extension RainbowBestViewController {
    @objc
    func tapBackButton(_ sender: UIButton) {
        print("tapBackButton")
    }
    
    @objc
    func tapCloseButton(_ sender: UIButton) {
        print("tapCloseButton")
    }
}

extension RainbowBestViewController: UITableViewDelegate {

}

extension RainbowBestViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 7:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = RainbowBestSectionHeaderView()
        switch section {
        case 0:
            header.setHeaderText(title: "사랑", text: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 진짜 뭐햌ㅋㅋㅋㅋ아 ㅋㅋㅋㅋㅋ오늘 잠 언제자 ㅋㅋㅋㅋㅁㅊㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
        
        default:
            header.setHeaderText(title: "사랑", text: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 진짜 뭐햌ㅋㅋㅋㅋ아 ㅋㅋㅋㅋㅋ오늘 잠 언제자 ㅋㅋㅋㅋㅁㅊㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 7:
            return RainbowBestSectionFooterView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.rainbowBookPage, for: indexPath) as? RainbowBookPageTableViewCell
        else { return UITableViewCell() }
        cell.setContentText(pages: [PageTextModel(title: "제 1장 3화", subtitle: "가나다라마바사아자", content: "엌ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ알아럼얼 ㅏ 아ㅓㅣ멍리ㅏㅁ어 ㅏ' ㅁㄴ이ㅏㅓㄹ미아 ㅓㅁㄴ인라ㅗ ㅇㅁ니ㅏ ㅁ노ㅠㄹ ㅍ", date: "2021.07.05"),
                                    PageTextModel(title: "제 1장 3화", subtitle: "가나다라마바사아자", content: "엌ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ알아럼얼 ㅏ 아ㅓㅣ멍리ㅏㅁ어 ㅏ' ㅁㄴ이ㅏㅓㄹ미아 ㅓㅁㄴ인라ㅗ ㅇㅁ니ㅏ ㅁ노ㅠㄹ ㅍ", date: "2021.07.05")])
        cell.selectionStyle = .none
        return cell
    }
    
}
