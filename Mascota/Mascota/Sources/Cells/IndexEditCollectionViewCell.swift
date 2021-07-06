//
//  IndexEditCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/07.
//

import UIKit

class IndexEditCollectionViewCell: UICollectionViewCell {
    
    private lazy var indexTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 16)
        $0.textColor = UIColor.macoBlack
    }
    
    private lazy var indexLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textColor = UIColor.macoDarkGray
        $0.text = "프롤로그"
    }
    
    lazy var moveButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        $0.tintColor = UIColor.macoDarkGray
    }
    
    lazy var changeButton: UIButton = UIButton().then {
        $0.setAttributedTitle("수정".convertColorFont(color: UIColor.macoDarkGray, fontSize: 14, type: .regular), for: .normal)
    }
    
    lazy var deleteButton: UIButton = UIButton().then {
        $0.setAttributedTitle("삭제".convertColorFont(color: UIColor.macoOrange, fontSize: 14, type: .regular), for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutEditComponents()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layoutEditComponents()
    }
    
    private func layoutEditComponents() {
        
        self.contentView.addSubviews(moveButton, indexLabel, indexTitleLabel, changeButton, deleteButton)
        
        moveButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(25)
            $0.width.equalTo(16)
            $0.height.equalTo(12)
        }

        indexLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(moveButton.snp.trailing).offset(17.5)
            $0.width.equalTo(52)
            $0.height.equalTo(21)
        }
//
        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(contentView.snp.trailing).inset(21)
            $0.height.equalTo(21)
            $0.width.equalTo(30)
        }
        
        changeButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-5)
            $0.height.equalTo(21)
            $0.width.equalTo(30)
        }
        indexTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(indexLabel.snp.trailing).offset(11)
            $0.trailing.equalTo(changeButton.snp.leading)
        }
    }
    
    func intializeData(_ tag: Int) {
        self.changeButton.tag = tag
        self.deleteButton.tag = tag
        self.indexLabel.text = "프롤로그"
        self.indexTitleLabel.text = "코봉이와의 7년"
    }
}
