//
//  Date+.swift
//  PodoRang
//
//  Created by coco on 2023/06/11.
//

import Foundation

extension Date {
    /// convert Date object to string with time
    func toStringWithTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd(E) HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    /// convert Date object to string without time
    func toStringWithoutTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
}
