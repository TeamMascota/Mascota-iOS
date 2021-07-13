//
//  RainbowBestViewController.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

class RainbowBestViewController: UIViewController {
    
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

extension RainbowBestViewController {
    @objc
    func tapBackButton(_ sender: UIBarItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func tapCloseButton(_ sender: UIBarItem) {
        let customLabelAlertView = CustomLabelAlertView()
        
        customLabelAlertView.setAttributedTitle(attributedText: "이별의 단계".attributedString(font: .macoFont(type: .bold, size: 17), color: .macoBlack, customLineHeight: 18, alignment: .center))
        
        customLabelAlertView.setAttributedDescription(attributedText: "이별의 단계가 초기화됩니다.\n무지개 다리를 나가시겠어요?"
                                                    .attributedString(font: .macoFont(type: .regular, size: 13), color: .macoBlack, customLineHeight: 25, alignment: .center))

        self.presentDoubleCustomAlert(view: customLabelAlertView,
                                      preferredSize: CGSize(width: 270, height: 130),
                                      firstHandler: { _ in
                                      },
                                      secondHandler: {  _ in
                                        self.dismiss(animated: true, completion: nil)
                                      },
                                      firstText: "취소", secondText: "나가기", color: .macoBlue)
    }
    
    @objc
    func tapNextButton(_ sender: UIButton) {
        navigationController?.pushViewController(RainbowEpillogueViewController(), animated: true)
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
            header.setHeaderText(title: "사랑", text: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋzzzzzㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 진짜 뭐햌ㅋㅋㅋㅋ아 ㅋㅋㅋㅋㅋ오늘 잠 언제자 ㅋㅋㅋㅋㅁㅊㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
        
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
        cell.bookPageView.leftPageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLeftBookPage(_:))))
        cell.bookPageView.rightPageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapRightBookPage(_:))))
        return cell
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
    
}
