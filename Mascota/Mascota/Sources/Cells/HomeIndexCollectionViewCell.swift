//
//  HomeIndexCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/05.
//

import UIKit

import SnapKit
import Then

enum IndexType: Int {
    case home = 0
    case edit
    case editPrologue
}

class HomeIndexCollectionViewCell: UICollectionViewCell {
    
    var indexType: IndexType = .editPrologue

    private lazy var indexLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textColor = UIColor.macoDarkGray
        $0.text = "프롤로그"
    }
    
    private lazy var indexTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 16)
        $0.textColor = UIColor.macoBlack
    }
    
    private lazy var episodeLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textColor = UIColor.macoDarkGray
    }
    
    lazy var indexDetailButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = UIColor.macoGray
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
//        indexType == .home ? layoutHomeComponents() : layoutEditComponents()
    }
    
    private func layoutHomeComponents() {
        self.contentView.addSubviews(indexLabel, indexTitleLabel, episodeLabel, indexDetailButton)
                
        indexLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(23)
            $0.width.equalTo(55)
        }
        
        indexTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(indexLabel.snp.trailing).offset(15)
        }
        
        indexDetailButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-25)
        }
        
        episodeLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(indexDetailButton.snp.leading).offset(-12)
        }
    }
    
    private func layoutEditComponents() {
        
        self.contentView.addSubviews(moveButton, indexLabel, indexTitleLabel, changeButton, deleteButton)
        
        moveButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(25)
        }
        
        indexLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(moveButton.snp.trailing).offset(17.5)
        }
//        
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
    }
    
    private func layoutPrologueComponents() {
        
        self.contentView.addSubviews(indexLabel, indexTitleLabel, changeButton, deleteButton)
        
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
    }
    
    func intializeData() {
        switch indexType {
        case .home:
            layoutHomeComponents()
        case .edit:
            layoutEditComponents()
        default:
            layoutPrologueComponents()
        }
        self.indexLabel.text = "프롤로그"
        self.indexTitleLabel.text = "코봉이와의 7년"
        self.episodeLabel.text = "총 \(3)화"
        
    }

}
