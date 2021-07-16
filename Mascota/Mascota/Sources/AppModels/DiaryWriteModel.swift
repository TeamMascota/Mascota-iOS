//
//  DiaryWriteModel.swift
//  Mascota
//
//  Created by apple on 2021/07/16.
//

import UIKit

struct DiaryWriteModel {
    var title: String
    var diaryImages: [UIImage]
    var contents: String
    var date: String
    var id: String // 목차 아이디
    
    
    func isEmpty() -> Bool {
        if self.title == "" || self.contents == "" || self.date == "" || self.id == "" {
            return true
        }
        return false
    }
}


