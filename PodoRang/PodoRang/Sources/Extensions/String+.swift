//
//  String+.swift
//  PodoRang
//
//  Created by coco on 2023/06/11.
//

import Foundation

extension String {
    /// convert String object to Date
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.date(from: self)
    }
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with argument: CVarArg, comment: String = "") -> String {
        return String(format: self.localized(comment: comment), argument)
    }
}
