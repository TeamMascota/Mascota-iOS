//
//  PetsCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/11.
//

import UIKit

class PetsCollectionViewCell: UICollectionViewCell {
    
    static let emoji: EmojiStyle = EmojiStyle()
    
    var kind: Int = 0
    var feeling: Int = 0
    
    let petImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "emoDogLove")
        $0.tintColor = UIColor.macoBlack
        $0.contentMode = .scaleAspectFit
    }
    
    let emotionLabel: UILabel = UILabel().then {
        $0.font = UIFont.macoFont(type: .regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = UIColor.macoGray
        $0.text = "ㅋㅋ"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutComponents()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.kind = 0
        self.feeling = 0
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.petImageView.image = PetsCollectionViewCell.emoji.getEmoji(kind: kind,
                                                                               feeling: feeling,
                                                                               color: .darkGray)
            } else {
                self.petImageView.image = PetsCollectionViewCell.emoji.getEmoji(kind: kind,
                                                                               feeling: feeling,
                                                                               color: .lightGray)
            }
        }
    }
    
    
    private func layoutComponents() {
        self.contentView.addSubviews(petImageView, emotionLabel)
        
        emotionLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            
        }
        
        petImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(emotionLabel.snp.top).offset(-8)
        }
    }
    
    func setData(kind: Int, feeling: Int, text: String, isSelected: Bool) {
        self.kind = kind
        self.feeling = feeling
        self.emotionLabel.text = PetsCollectionViewCell.emoji.getEmojiText(kind: kind, feeling: feeling)
        if isSelected {
            self.petImageView.image = PetsCollectionViewCell.emoji.getEmoji(kind: kind, feeling: feeling, color: .darkGray)
        } else {
            self.petImageView.image = PetsCollectionViewCell.emoji.getEmoji(kind: kind, feeling: feeling, color: .lightGray)
        }
        
    }

}
