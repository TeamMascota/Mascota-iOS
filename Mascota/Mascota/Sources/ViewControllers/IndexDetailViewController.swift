//
//  IndexDetailViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

import SnapKit
import Then


class IndexDetailViewController: UIViewController {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var indexTitle: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var tableContents: [IndexModel] = []
    var currentID: String = ""
    
    var isToggled: Bool = false
    
    lazy var indexStackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alpha = 0.0
    }
    
    lazy var indexDetailTableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.backgroundColor = .clear
        $0.tableHeaderView = nil
    }
    
    
    
    lazy var navigationBar: UIView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        layoutComponents()
        layoutStackView()
        registerTableView()
        registerTableViewCells()
    }
    
    private func layoutComponents() {
        self.view.addSubview(indexDetailTableView)
        
        indexDetailTableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
            $0.bottom.equalToSuperview()
        }
        
        self.view.addSubview(indexStackView)
        
        indexStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.top.equalTo(navigationView.snp.bottom)
            $0.height.equalTo(42 * tableContents.count)
        }

    }

    private func layoutStackView() {
        for (index, chapter) in tableContents.enumerated() {
            let view: UIView = UIView().then {
                $0.backgroundColor = UIColor.macoIvory
            }
            
            let seperateorView: UIView = UIView().then {
                $0.backgroundColor = UIColor.macoLightGray
            }
            
            let dropDownIndexLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 14)
                $0.textColor = UIColor.macoDarkGray
                $0.textAlignment = .left
                $0.text = index == 0 ? "프롤로그" : "제 \(index)장"
            }
            
            let dropDownIndexTitleLabel: UILabel = UILabel().then {
                $0.font = UIFont.macoFont(type: .regular, size: 16)
                $0.textColor = UIColor.macoBlack
                $0.textAlignment = .left
                $0.text = chapter.chapterTitle
            }
            
            indexStackView.addArrangedSubview(view)
            view.addSubviews(dropDownIndexLabel, dropDownIndexTitleLabel, seperateorView)
            
            view.snp.makeConstraints {
                $0.height.equalTo(42)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(touchDropDownView(_:))))
            
            seperateorView.snp.makeConstraints {
                $0.height.equalTo(1)
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            
            dropDownIndexLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.equalTo(55)
                $0.leading.equalToSuperview().offset(21)
            }
            
            dropDownIndexTitleLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(dropDownIndexLabel.snp.trailing).offset(-5)
                $0.trailing.equalToSuperview().offset(21)
            }
            
        }
    }

    private func registerTableView() {
        self.indexDetailTableView.delegate = self
        self.indexDetailTableView.dataSource = self
    }
    
    private func registerTableViewCells() {
        self.indexDetailTableView.register(UINib(nibName: AppConstants.TableCells.indexDetailTableViewCell, bundle: nil),
                                           forCellReuseIdentifier: AppConstants.TableCells.indexDetailTableViewCell)
        
        self.indexDetailTableView.register(IndexDetailHeaderView.self,
                                           forHeaderFooterViewReuseIdentifier: AppConstants.TableViewHeaders.indexDetailHeaderView)
    }
    
    @objc
    func touchDropDownView(_ sender: UITapGestureRecognizer) {
        print(1)
    }
    
    @IBAction func touchToggleButton(_ sender: Any) {
    
        UIView.animate(withDuration: 0.5) {
            self.toggleButton.transform = self.isToggled ? CGAffineTransform(rotationAngle: .pi * 2): CGAffineTransform(rotationAngle: .pi)
            self.indexStackView.alpha = self.isToggled ? 0.0 : 1.0
        }
        isToggled.toggle()
    }
  
}

extension IndexDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "수정") {_,_,_ in
            print("edited")
        }.then {
            $0.backgroundColor = UIColor.lightGray
            $0.title = "수정"
            
        }
        
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") {_,_,_ in
            print("deleted")
        }.then {
            $0.backgroundColor = UIColor.macoOrange
            $0.title = "삭제"
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}

extension IndexDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "IndexDetailHeaderView") as? IndexDetailHeaderView else {
            return nil
        }
        header.initializeValues(month: "7", total: "11")
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableCells.indexDetailTableViewCell,
                                                       for: indexPath) as? IndexDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.initializeData()
        return cell
    }
    
}
