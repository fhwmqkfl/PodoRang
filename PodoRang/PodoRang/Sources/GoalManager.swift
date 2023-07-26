//
//  GoalManager.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation
import RealmSwift

/// Manage `Goal` instances.
final class GoalManager {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func fetch() -> [Goal] {
        let goalList = realm.objects(Goal.self)
        return Array(goalList)
    }
    
    func fetchGoal(index: Int) -> Goal {
        return realm.objects(Goal.self)[index]
    }
    
    func fetchInprogress() -> [Goal] {
        return realm.objects(Goal.self).filter { $0.isFinished == .inProgress }.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchInprogress(index: Int) -> Goal {
        return fetchInprogress()[index]
    }
    
    func fetchFinished() -> [Goal] {
        return realm.objects(Goal.self).filter { $0.isFinished == .finished }.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchFinished(index: Int) -> Goal {
        return fetchFinished()[index]
    }
    
    func add(_ goal: Goal) {
        try! realm.write {
            realm.add(goal)
        }
    }
    
    func delete(deleteGoal: Goal) {
        try! realm.write {
            realm.delete(deleteGoal)
        }
    }
    
    func update(goal: Goal, title: String, grapeType: Grape) {
        try! realm.write{
            goal.title = title
            goal.grapeType = grapeType
        }
    }
    
    func updateGoal(newCheckDays: [Date], goal: Goal) {
        try! realm.write {
            let realmList = List<Date>()
            realmList.append(objectsIn: newCheckDays)
            goal.checkDays = realmList
        }
    }
    
    // TODO: change dday calculate -> check hour,min
    func calculateDday(goal: Goal, targetDate: Date) -> Int {
        let grainCount = Double(goal.grainCount.rawValue)
        let enddate = goal.startDate.addingTimeInterval(60 * 60 * 24 * grainCount)
        let dday = Calendar.current.dateComponents([.day], from: targetDate, to: enddate).day!
        return dday
    }
    
    func updateGoalStatus() {
        let goalList = realm.objects(Goal.self)
        let today = Date()
        
        for index in 0..<goalList.count {
            let goal = goalList[index]
            let dday = calculateDday(goal: goal, targetDate: today)
            try! realm.write {
                if dday >= 0 {
                    goal.isFinished = .inProgress
                } else {
                    goal.isFinished = .finished
                }
                
                updateGoalSuccessed(goal: goal)
            }
        }
    }
    
    func updateGoalSuccessed(goal: Goal) {
        if goal.grainCount.rawValue == goal.checkDays.count {
            goal.isSuccessed = true
        } else {
            goal.isSuccessed = false
        }
    }
}
