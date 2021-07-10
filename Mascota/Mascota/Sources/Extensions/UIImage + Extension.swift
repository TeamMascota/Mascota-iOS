//
//  UIImage + Extension.swift
//  Mascota
//
//  Created by apple on 2021/07/06.
//

import UIKit

extension UIImage {
    convenience init?(view: UIView) {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 39, height: 83))
        let image = renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }

        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        } else {
            return nil
        }
    }
}
