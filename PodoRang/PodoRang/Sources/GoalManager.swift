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
    
    private var goalList: [Goal] = []
    
    func setupData() {
        goalList = [
            Goal(title: "progrss-first", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "progrss-second", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "progrss-third", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "progrss-fourth", startDate: Date(), grainCount: .oneWeek, grapeType: .purple),
            Goal(title: "finished-first", startDate: Date(), grainCount: .oneWeek, grapeType: .purple, isFinished: true),
            Goal(title: "finished-second", startDate: Date(), grainCount: .oneWeek, grapeType: .purple, isFinished: true)
        ]
    }
    
    func fetch(isfinished: Bool) -> [Goal] {
        return goalList.filter { $0.isFinished == isfinished }
    }
    
    func add(_ goal: Goal) {
        goalList.append(goal)
    }
}
