//
//  GoalStatus.swift
//  PodoRang
//
//  Created by coco on 2023/07/27.
//

import UIKit
import RealmSwift

enum GoalStatus: Int, PersistableEnum {
    case inProgress = 0
    case finished
}
