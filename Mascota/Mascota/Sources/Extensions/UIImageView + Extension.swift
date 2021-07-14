//
//  UIImageView + Extension.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import UIKit
import Kingfisher

// 이미지 뷰 서버 통신
extension UIImageView {
    func updateServerImage(_ imagePath: String) {
        guard let url = URL(string: imagePath) else {
            return
        }
        let processor = RoundCornerImageProcessor(cornerRadius: 10)
        self.kf.indicatorType = .activity

        self.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
