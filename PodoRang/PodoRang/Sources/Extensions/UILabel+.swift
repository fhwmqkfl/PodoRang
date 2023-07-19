//
//  UILabel+.swift
//  PodoRang
//
//  Created by coco on 2023/06/28.
//

import UIKit

extension UILabel {
    /// customize Label line spacing
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
