//
//  PaddingLabel.swift
//  PodoRang
//
//  Created by coco on 2023/07/14.
//

import UIKit

class PaddingLabel: UILabel {
    @IBInspectable var leftInset: CGFloat = 15
    @IBInspectable var rightInset: CGFloat = 15
    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottonInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottonInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottonInset)
    }
        
    override var bounds: CGRect {
        didSet {
            let horizontalInset = leftInset + rightInset
            preferredMaxLayoutWidth = bounds.width - horizontalInset
        }
    }
}
