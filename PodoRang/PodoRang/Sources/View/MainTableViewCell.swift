//
//  MainTableViewCell.swift
//  PodoRang
//
//  Created by coco on 2023/05/26.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifier = "MainTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ddayLabel: PaddingLabel!
}
