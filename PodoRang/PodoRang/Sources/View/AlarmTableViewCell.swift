//
//  AlarmTableViewCell.swift
//  PodoRang
//
//  Created by coco on 2023/06/03.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    static let identifier = "alarmCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
}
