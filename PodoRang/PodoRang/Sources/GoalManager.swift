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
    
    func add(_ goal: Goal) {
        try! realm.write {
            realm.add(goal)
        }
    }
    
    func fetch() -> [Goal] {
        let goalList = realm.objects(Goal.self)
        
        return Array(goalList)
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
    
    func updateGoalStatus() {
        let goalList = realm.objects(Goal.self)
        
        for index in 0..<goalList.count {
            let goal = goalList[index]
            
            try! realm.write {
                if ddayExist(goal: goal) {
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
    
    func delete(deleteGoal: Goal) {
        try! realm.write {
            realm.delete(deleteGoal)
        }
    }
    
    func calculateDday(goal: Goal, targetDate: Date) -> Int? {
        let secondUnit: Double = 60
        let minuteUnit: Double = 60
        let hourUnit: Double = 24
        let grainCount = Double(goal.grainCount.rawValue)
        let enddate = goal.startDate.addingTimeInterval(secondUnit * minuteUnit * hourUnit * grainCount)
        let dday = Calendar.current.dateComponents([.day, .hour, .minute], from: targetDate, to: enddate)
        
        guard let day = dday.day,
              let hour = dday.hour,
              let minute = dday.minute
        else { return nil }
    
        if day >= 0, hour >= 0, minute >= 0 {
            return dday.day
        } else {
            return nil
        }
    }
    
    func ddayExist(goal: Goal) -> Bool {
        let today = Date()
        if calculateDday(goal: goal, targetDate: today) != nil {
            return true
        }
        return false
    }
}
