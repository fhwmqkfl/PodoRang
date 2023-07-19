//
//  UIStackView+.swift
//  PodoRang
//
//  Created by coco on 2023/06/10.
//

import UIKit

extension UIStackView {
    /// adds multiple views to the sub of self
    func addArragnedSubViews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
