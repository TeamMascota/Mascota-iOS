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
    @IBOutlet weak var imageViewButton: UIButton!
    
    @IBAction func tapDeleteButton() {
        print("closed")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
