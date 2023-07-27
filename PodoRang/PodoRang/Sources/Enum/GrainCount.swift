//
//  GrainCount.swift
//  PodoRang
//
//  Created by coco on 2023/07/27.
//

import Foundation
import RealmSwift

enum GrainCount: Int, CaseIterable, PersistableEnum {
    case oneWeek = 7
    case twoWeeks = 14
    case threeWeeks = 21
    case none
}
