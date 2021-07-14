//
//  DateProcessing.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/15.
//

import Foundation
struct DateProcessing {
    // MARK: - 아래 형식의 날짜를 정제해주는 메소드

    // 2019-09-21T05:44:28.000+0000

    static func getDate(rawDate: String, completion: @escaping (DateValueObject) -> Void) {
        let seprateDate = rawDate.split(separator: "T")
        let day = String(seprateDate[0])
        let time = String(seprateDate[1])
        let seprateDay = day.split(separator: "-")
        let seprateTime = time.split(separator: ":")
        let dateVO = DateValueObject(yyyy: String(seprateDay[0]), mmm: String(seprateDay[1]), ddd: String(seprateDay[2]), hour: String(seprateTime[0]), min: String(seprateTime[1]), sec: String(seprateTime[2]))
        completion(dateVO)
    }

}


class DateValueObject {
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var min: Int
    var sec: Int
    init() {
        year = 2019
        month = 01
        day = 01
        hour = 00
        min = 00
        sec = 00
    }

    init(yyyy: String, mmm: String, ddd: String, hour: String, min: String, sec: String) {
        year = Int(yyyy) ?? 0
        month = Int(mmm) ?? 0
        day = Int(ddd) ?? 0
        self.hour = Int(hour) ?? 0
        self.min = Int(min) ?? 0
        self.sec = Int(sec) ?? 0
        var ddd = day
        var hhh = self.hour + 9
        if hhh > 23 {
            if month >= 8 {
                if month % 2 == 0 {
                    if ddd == 31 {
                        ddd = 0
                        month = month + 1
                    } else { ddd = ddd + 1 }
                }
            } else {
                if month % 2 == 1 {
                    if ddd == 30 {
                        ddd = 0
                        month = month + 1
                    } else { ddd = ddd + 1 }
                }
            }
            hhh = hhh - 24
        }
        day = ddd
        self.hour = hhh
    }
}

