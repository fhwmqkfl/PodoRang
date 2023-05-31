//
//  ProjectManager.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation

/// Manage `Project` instances.
final class ProjectManager {
    static let shared = ProjectManager()
    
    private init() {}
    
    private var projectList: [Project] = []
    
    func setupData() {
        projectList = [
            Project(title: "progrss-first"),
            Project(title: "progrss-second"),
            Project(title: "progrss-third"),
            Project(title: "progrss-fourth"),
            Project(title: "finished-first", isFinished: true),
            Project(title: "finished-second", isFinished: true)
        ]
    }
    
    func fetch(isfinished: Bool) -> [Project] {
        return projectList.filter { $0.isFinished == isfinished }
    }
    
    func add(_ project: Project) {
        projectList.append(project)
    }
}
