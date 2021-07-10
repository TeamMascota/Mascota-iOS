//
//  IndexDetailHeaderView.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

import SnapKit
import Then
class IndexDetailHeaderView: UITableViewHeaderFooterView {
    lazy var monthLabel: UILabel = UILabel().then {
        $0.text = "4월"
        $0.font = UIFont.macoFont(type: .medium, size: 20)
        $0.textColor = UIColor.macoBlack
    }
    
    lazy var totalEpisodeLabel: UILabel = UILabel().then {
        $0.text = "총 4화"
        $0.font = UIFont.macoFont(type: .regular, size: 13)
        $0.textColor = UIColor.macoDarkGray
    }
    
    lazy var separatorView: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoOrange
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.macoIvory
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder doesn't exist")
    }
    
    private func layoutComponents() {
        self.contentView.addSubviews(monthLabel, totalEpisodeLabel, separatorView)
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        monthLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(5)
            $0.bottom.equalTo(separatorView.snp.top).offset(-6.6)
        }
        
        totalEpisodeLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(-3)
            $0.bottom.equalTo(separatorView.snp.top).offset(-10)
        }
    }
    
    func initializeValues(month: String, total: String) {
        self.monthLabel.text = month + "월"
        self.totalEpisodeLabel.text = "총 "+total+"화"
        
    }
}
