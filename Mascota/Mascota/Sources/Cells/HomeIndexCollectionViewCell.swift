//
//  HomeIndexCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class HomeIndexCollectionViewCell: UICollectionViewCell {
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutHomeComponents()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.indexLabel.text = ""
        self.episodeLabel.text = ""
        self.indexTitleLabel.text = ""
        self.episodeLabel.isHidden = false
    }

    func initializeData(data: IndexModel, tag: Int) {
        switch data.chapter {
        case -1:
            self.indexLabel.text = "에필로그"
        case 0:
            self.indexLabel.text = "프롤로그"
            self.episodeLabel.isHidden = true
        default:
            self.indexLabel.text = "제 \(data.chapter)장"
        }
       
        self.indexTitleLabel.text = data.chapterTitle
        self.episodeLabel.text = "총 \(data.episodePerchapterCount ?? 0)화"
    }
}
