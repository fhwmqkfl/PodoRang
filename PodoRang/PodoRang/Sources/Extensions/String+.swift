//
//  String+.swift
//  PodoRang
//
//  Created by coco on 2023/06/11.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MM월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        return formatter.date(from: self)
    }
}
