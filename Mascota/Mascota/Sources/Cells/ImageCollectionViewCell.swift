//
//  ImageCollectionViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/13.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func initializeCell(data: UIImage?){
        if let image = data {
//            userImageView.image = dasda
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.macoOrange.cgColor
            self.userImageView.image = image
            self.symbolImageView.isHidden = true
        } else {
            self.symbolImageView.isHidden = false
            self.userImageView.image = UIImage()
        }
    }
    

}
