//
//  GoalManager.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation

/// Manage `Goal` instances.
final class GoalManager {
    static let shared = GoalManager()
    
    private init() {}
    
    var goalList: [Goal] = []
    
    func setupData() {
        goalList = [
            Goal(title: "progrss-first", startDate: "2023년 6월 19일".toDate()!, grainCount: .oneWeek, grapeType: .purple, checkDays: ["2023년 6월 20일".toDate()!, "2023년 5월 30일".toDate()!]),
            Goal(title: "progrss-second", startDate: "2023년 7월 30일".toDate()!, grainCount: .twoWeeks, grapeType: .purple, checkDays: ["2023년 6월 23일".toDate()!, "2023년 5월 29일".toDate()!]),
            Goal(title: "progrss-third", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "progrss-fourth", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "finished-first", startDate: "2023년 5월 19일".toDate()!, grainCount: .oneWeek, grapeType: .purple, isFinished: .finished),
            Goal(title: "finished-second", startDate: "2023년 5월 10일".toDate()!, grainCount: .oneWeek, grapeType: .purple, isFinished: .finished)
        ].sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchInprogress() -> [Goal] {
        return goalList.filter { $0.isFinished == .inProgress}.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchInprogress(index: Int) -> Goal {
        return fetchInprogress()[index]
    }
    
    func fetchFinished() -> [Goal] {
        return goalList.filter { $0.isFinished == .finished}.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchFinished(index: Int) -> Goal {
        return fetchFinished()[index]
    }
    
    func add(_ goal: Goal) {
        goalList.append(goal)
    }
    
    func delete(deleteGoal: Goal, index: Int) {
        goalList.remove(at: index)
    }
    
    func update(goal: Goal, index: Int) {
        goalList[index] = goal
    }
    
    func updateGoal(newCheckDays: [Date], index: Int) {
        goalList[index].checkDays = newCheckDays
    }
    
    func calculateDday(goal: Goal, targetDate: Date) -> Int {
        let grainCount = Double(goal.grainCount.rawValue)
        let enddate = goal.startDate.addingTimeInterval(60 * 60 * 24 * grainCount)
        let dday = Calendar.current.dateComponents([.day], from: targetDate, to: enddate).day!
        return dday
    }
    
    func updateGoalStatus() {
        let today = Date()
        
        for index in 0..<goalList.count {
            let dday = calculateDday(goal: goalList[index] , targetDate: today)
            if dday >= 0 {
                goalList[index].isFinished = .inProgress
            } else {
                goalList[index].isFinished = .finished
            }
        }
    }
}
