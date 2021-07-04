//
//  BookPageTableViewCell.swift
//  Mascota
//
//  Created by apple on 2021/07/04.
//

import UIKit
import SnapKit
import Then


class BookPageTableViewCell: UITableViewCell {

    @IBOutlet weak var superView: UIView!
    private lazy var bookHomePageView: BookHomePageView = BookHomePageView().then {
        $0.setContentText()
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutComponents()
        // Initialization code
    }
    
    private func layoutComponents() {
        superView.addSubview(bookHomePageView)
        bookHomePageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
