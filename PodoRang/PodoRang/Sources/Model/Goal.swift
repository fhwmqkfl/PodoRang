//
//  Goal.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation
import RealmSwift

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
        self.grapeType = grapeType ?? .none
    }
    
    func checkDaysToArray() -> [Date] {
        return Array(self.checkDays)
    }
}
