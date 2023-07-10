//
//  GoalManager.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation
import RealmSwift

// TODO: DELETE 'goalList' & UPDATE 'updateGoal' method

/// Manage `Goal` instances.
final class GoalManager {
    static let shared = GoalManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func setupData() {
        /// realm local file url
        // print("file url: \(realm.configuration.fileURL)")
    }
    
    func fetchInprogress() -> [Goal] {
        return realm.objects(Goal.self).filter { $0.isFinished == .inProgress}.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchInprogress(index: Int) -> Goal {
        return fetchInprogress()[index]
    }
    
    func fetchFinished() -> [Goal] {
        return realm.objects(Goal.self).filter { $0.isFinished == .finished}.sorted(by: { $0.startDate < $1.startDate })
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
    
    func updateGoal(newCheckDays: [Date], index: Int) {
    }
    
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
            let dday = calculateDday(goal: goalList[index], targetDate: today)
            if dday >= 0 {
                try! realm.write {
                    goalList[index].isFinished = .inProgress
                }
            } else {
                try! realm.write {
                    goalList[index].isFinished = .finished
                }
            }
        }
    }
}
