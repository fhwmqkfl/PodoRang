//
//  Goal.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation

enum Grape: Int, CaseIterable {
    case purple
    case red
    case green
}

enum GrainCount: Int, CaseIterable {
    case oneWeek = 7
    case twoWeeks = 14
    case threeWeeks = 21
}

struct Goal {
    var title: String
    var startDate: Date
    var grainCount: GrainCount
    var grapeType: Grape
    var checkDays: [Date] = []
    var isFinished: Bool = false
    var isSuccessed: Bool = false
}
