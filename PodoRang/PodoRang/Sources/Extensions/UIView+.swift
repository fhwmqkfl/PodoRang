//
//  UIView+.swift
//  PodoRang
//
//  Created by coco on 2023/06/10.
//

import UIKit

extension UIView {
    /// adds multiple views to the sub of self
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
