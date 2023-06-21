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
            Goal(title: "progrss-first", startDate: Date(), grainCount: .oneWeek, grapeType: .purple, checkDays: ["2023년 6월 20일".toDate()!, "2023년 5월 30일".toDate()!]),
            Goal(title: "progrss-second", startDate: Date(), grainCount: .oneWeek, grapeType: .purple, checkDays: ["2023년 6월 21일".toDate()!, "2023년 5월 29일".toDate()!]),
            Goal(title: "progrss-third", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "progrss-fourth", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "finished-first", startDate: Date(), grainCount: .oneWeek, grapeType: .purple, isFinished: .finished),
            Goal(title: "finished-second", startDate: Date(), grainCount: .oneWeek, grapeType: .purple, isFinished: .finished)
        ].sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchInprogress() -> [Goal] {
        return goalList.filter{$0.isFinished == .inProgress}.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func fetchFinished() -> [Goal] {
        return goalList.filter{$0.isFinished == .finished}.sorted(by: { $0.startDate < $1.startDate })
    }
    
    func add(_ goal: Goal) {
        goalList.append(goal)
    }
}
