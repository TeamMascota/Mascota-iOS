//
//  RegisterMyPetCollectionViewCell.swift
//  Mascota
//
//  Created by DYS on 2021/07/05.
//

protocol RegisterMyPetProtocol {
    func deselectingCell(text: String)
}

import UIKit

class RegisterMyPetCollectionViewCell: UICollectionViewCell {
    
    var registerMyPetProtocol: RegisterMyPetProtocol?

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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                characterNumberLabel.backgroundColor = .macoOrange
                closeButton.imageView?.image = UIImage(named: "btnIconQuit")
                layer.borderWidth = 1.0
                layer.borderColor = UIColor.macoOrange.cgColor
            } else {
                characterNumberLabel.backgroundColor = .macoLightGray
                closeButton.imageView?.image = UIImage(named: "btnIconQuitDefaultGray")
                layer.borderWidth = 1.0
                layer.borderColor = UIColor.macoLightGray.cgColor
            }
        }
    }
    
    override func prepareForReuse() {
        myPetImage.image = nil
    }
}
