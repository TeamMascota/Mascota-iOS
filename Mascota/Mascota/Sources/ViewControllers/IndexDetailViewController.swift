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
    lazy var indexDetailTableView: UITableView = UITableView().then {
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
    
    @IBAction func touchToggleButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.toggleButton.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
    }
  
}

extension IndexDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
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
