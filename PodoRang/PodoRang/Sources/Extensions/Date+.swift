//
//  Date+.swift
//  PodoRang
//
//  Created by coco on 2023/06/11.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        
        return formatter.string(from: self)
    }
}
