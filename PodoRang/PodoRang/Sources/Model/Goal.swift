//
//  Goal.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation
import RealmSwift

enum GoalStatus: Int, PersistableEnum {
    case inProgress = 0
    case finished
}

enum Grape: Int, CaseIterable, PersistableEnum {
    case purple = 0
    case red
    case green
    case none
}

enum GrainCount: Int, CaseIterable, PersistableEnum {
    case oneWeek = 7
    case twoWeeks = 14
    case threeWeeks = 21
    case none
}

class Goal: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var startDate: Date
    @Persisted var grainCount: GrainCount
    @Persisted var grapeType: Grape
    @Persisted var checkDays: List<Date> = List()
    @Persisted var isFinished: GoalStatus = .inProgress
    @Persisted var isSuccessed: Bool = false
    
    convenience init(title: String, startDate: Date, grainCount: GrainCount, grapeType: Grape?) {
        self.init()
        self.title = title
        self.startDate = startDate
        self.grainCount = grainCount
        self.grapeType = grapeType ?? .purple
    }
}
