//
//  IndexEditPrologueCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/07.
//

import UIKit

class IndexEditPrologueCollectionViewCell: UICollectionViewCell {
    
    private lazy var indexLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textColor = UIColor.macoDarkGray
        $0.text = "프롤로그"
    }
    
    private lazy var indexTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 16)
        $0.textColor = UIColor.macoBlack
    }
    
    lazy var changeButton: UIButton = UIButton().then {
        $0.setAttributedTitle("수정".convertColorFont(color: UIColor.macoDarkGray, fontSize: 14, type: .regular), for: .normal)
    }
    
    lazy var deleteButton: UIButton = UIButton().then {
        $0.setAttributedTitle("삭제".convertColorFont(color: UIColor.macoOrange, fontSize: 14, type: .regular), for: .normal)
    }
    
    lazy var sepeartorView: UIView = UIView().then {
        $0.backgroundColor = UIColor.macoLightGray
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutPrologueComponents()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.indexLabel.text = ""
        self.indexTitleLabel.text = ""
    }
    private func layoutPrologueComponents() {
        
        self.contentView.addSubviews(indexLabel, indexTitleLabel, changeButton, deleteButton, sepeartorView)
        
        indexLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(25)
        }

        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-21)
        }
        
        changeButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-5)
        }
        
        indexTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(indexLabel.snp.trailing).offset(11)
            $0.width.equalTo(162)
        }
        
        sepeartorView.snp.makeConstraints {
            $0.height.equalTo(0.8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func intializeData(_ tag: Int) {
        self.deleteButton.tag = tag
        self.changeButton.tag = tag
        self.indexLabel.text = "프롤로그"
        self.indexTitleLabel.text = "코봉이와의 7년"
        
    }

}
