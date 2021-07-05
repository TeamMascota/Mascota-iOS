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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initializeData() {
        self.dayLabel.text = "11일"
        self.weekDayLabel.text = "화욜"
        self.emotionImageView.image = UIImage()
        self.titleLabel.text = "가나다라마ㅏ사"
        self.contentLabel.text = "askdfjkljdf klasdjfklasdjfk lajsdfk jaklf klasf"
        self.petImageView.image = UIImage()
    }
    
}
