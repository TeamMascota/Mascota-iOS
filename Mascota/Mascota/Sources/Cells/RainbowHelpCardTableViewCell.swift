//
//  RainbowHelpCardTableViewCell.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

import SnapKit
import Then

class RainbowHelpCardTableViewCell: UITableViewCell {
    
    private lazy var helpCardButton = UIButton()
    
    private lazy var helpCardImage = UIImage(named: "helpCard")
    
    private lazy var cardTextLabel = UILabel().then {
        $0.font = .macoFont(type: .regular, size: 14)
        $0.textColor = .macoDarkGray
        $0.textAlignment = .left
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHelpCardButton()
        setRainbowHelpCardTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        cardTextLabel.text = nil
    }
    
    private func setHelpCardButton() {
        helpCardButton.setBackgroundImage(helpCardImage, for: .normal)
        
        helpCardButton.addSubviews(cardTextLabel)
        
        cardTextLabel.snp.makeConstraints {
            $0.top.equalTo(helpCardButton.snp.top).offset(11)
            $0.bottom.equalTo(helpCardButton.snp.bottom).inset(12)
            $0.leading.equalTo(helpCardButton.snp.leading).offset(14)
            $0.trailing.equalTo(helpCardButton.snp.trailing).inset(28)
        }
    }
    
    private func setRainbowHelpCardTableViewCell() {
        backgroundColor = .clear
        addSubviews(helpCardButton)
        
        helpCardButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    // 추후 Api 명세 나오면 모델로 교체 예정
    public func setCardText(kind: String, text: String) {
        
        let kindAttr = NSMutableAttributedString(string: kind, attributes: [NSAttributedString.Key.font: UIFont.macoFont(type: .regular, size: 14)])
        kindAttr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.macoGray], range: NSRange(location: 0, length: kindAttr.length))
        
        let textAttr = NSMutableAttributedString(string: " \(text)", attributes: [NSAttributedString.Key.font: UIFont.macoFont(type: .regular, size: 14)])
        textAttr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.macoDarkGray], range: NSRange(location: 0, length: textAttr.length))
        
        let fullText = NSMutableAttributedString()
           
        fullText.append(kindAttr)
        fullText.append(textAttr)
        
        cardTextLabel.attributedText = fullText
    }

}
