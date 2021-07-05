//
//  RainbowButtonTableViewCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class RainbowButtonTableViewCell: UITableViewCell {
    
    private lazy var button = MacoButton(color: .blue).then {
        $0.setMacoButtonTitle("반려동물과 이별했나요?", for: .normal)
    }
    
    private lazy var macoImageView = UIImageView().then {
        $0.image = UIImage(named: "illustExample")
        $0.contentMode = .scaleAspectFit
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setRainbowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setRainbowButton() {
        addSubviews(button, macoImageView)
        
        button.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(28)
            $0.top.equalToSuperview().offset(17)
        }
        
        macoImageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview()
        }

        backgroundColor = .macoIvory
    }

}
