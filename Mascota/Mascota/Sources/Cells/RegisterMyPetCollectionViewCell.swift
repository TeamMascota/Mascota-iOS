//
//  RegisterMyPetCollectionViewCell.swift
//  Mascota
//
//  Created by DYS on 2021/07/05.
//

import UIKit

class RegisterMyPetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myPetImage: UIImageView!
    @IBOutlet weak var characterNumberLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterNumberLabel.font = .macoFont(type: .regular, size: 15.0)
    }
    
    override func layoutIfNeeded() {
        
        myPetImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        myPetImage.image = nil
    }
}
