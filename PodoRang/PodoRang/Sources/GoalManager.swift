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
            Goal(title: "progrss-first"),
            Goal(title: "progrss-second"),
            Goal(title: "progrss-third"),
            Goal(title: "progrss-fourth"),
            Goal(title: "finished-first", isFinished: true),
            Goal(title: "finished-second", isFinished: true)
        ]
    }
    
    func fetch(isfinished: Bool) -> [Goal] {
        return goalList.filter { $0.isFinished == isfinished }
    }
    
    func add(_ goal: Goal) {
        goalList.append(goal)
    }
}
