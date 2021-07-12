//
//  RainbowHelpHeaderTableViewCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class RainbowHelpHeaderTableViewCell: UITableViewCell {
    
    private lazy var helpLabel = UILabel().then {
        $0.text = "도움글"
        $0.font = .macoFont(type: .medium, size: 20)
    }
    
    public lazy var helpButton = UIButton().then {
        $0.setImage(.add, for: .normal) // 이미지 넣기
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var underLineView = UIView().then {
        $0.backgroundColor = .macoDarkGray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setRainbowHelpHeaderTableViewCell()
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
    
    private func setRainbowHelpHeaderTableViewCell() {
        backgroundColor = .clear
        
        contentView.addSubviews(helpLabel, helpButton, underLineView)
        
        helpLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(21)
        }
        
        helpButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(helpLabel.snp.centerY)
        }
        
        underLineView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
            $0.top.equalTo(helpLabel.snp.bottom).offset(3)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
}
