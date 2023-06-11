//
//  Goal.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation

enum Grape {
    case purple
    case red
    case greeb
}

enum GrainCount: Int {
    case oneWeek = 7
    case twoWeeks = 14
    case threeWeeks = 21
}

struct Goal {
    var title: String?
    var startDate: Date?
    var grainCount: GrainCount = .oneWeek
    var grapeType: Grape = .purple
    var checkDays: [Date] = []
    var isFinished: Bool = false
    var isSuccessed: Bool = false
}
