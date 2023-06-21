//
//  Date+.swift
//  PodoRang
//
//  Created by coco on 2023/06/11.
//

import Foundation

extension Date {
    func toStringWithTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd(E) HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter.string(from: self)
    }
    
    func toStringWithoutTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter.string(from: self)
    }
}
