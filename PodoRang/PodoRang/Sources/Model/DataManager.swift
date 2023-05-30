//
//  DataManager.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    private var projectArray: [Project] = []
    
    func setupData() {
        projectArray = [
            Project(title: "progrss-first"),
            Project(title: "progrss-second"),
            Project(title: "progrss-third"),
            Project(title: "progrss-fourth"),
            Project(title: "finished-first", isFinished: true),
            Project(title: "finished-second", isFinished: true)
        ]
    }
    
    func getArray() -> [Project] {
        return projectArray
    }
    
    func fetchArray(isfinished: Bool) -> [Project] {
        let array = projectArray.filter { project in
            project.isFinished == isfinished
        }
        
        return array
    }
    
    func addProject(_ project: Project) {
        projectArray.append(project)
    }
}
