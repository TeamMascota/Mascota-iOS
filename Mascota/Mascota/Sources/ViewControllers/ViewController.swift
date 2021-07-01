//
//  ViewController.swift
//  Mascota
//
//  Created by apple on 2021/06/29.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    let bookView = BookPageView(type: .rainbow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bookView)
        bookView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(250)
        }
        // Do any additional setup after loading the view.
    }

}
