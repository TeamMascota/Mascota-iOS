//
//  IndexDetailTableViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

class IndexDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.macoIvory
        initializeView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dayLabel.text = ""
        self.weekDayLabel.text = ""
        emotionImageView.image = UIImage()
        titleLabel.text = ""
        contentLabel.text = ""
        petImageView.image = UIImage()
        petImageView.isHidden = false
    }
    
    private func initializeView() {
        self.contentView.backgroundColor = UIColor.macoIvory
        petImageView.layer.borderColor = UIColor.macoOrange.cgColor
        petImageView.layer.borderWidth = 1
        petImageView.layer.cornerRadius = 3
    }
    
    
    
    func initializeData(data: DetailDiaryModel) {
        self.dayLabel.text = data.date
        self.weekDayLabel.text = data.weekday
        self.emotionImageView.image = EmojiStyle().getEmoji(kind: data.kind,
                                                            feeling: data.feeling)
        self.titleLabel.text = data.title
        self.contentLabel.text = data.contents
        
        if let url = data.image {
            self.petImageView.updateServerImage(url)
        } else {
            self.petImageView.isHidden = true
        }
        
        
    }
    
}
