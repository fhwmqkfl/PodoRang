//
//  DataManager.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import Foundation

final class DataManager {
    private var progressList: [ProgressProject] = []
    private var finishedList: [FinishProject] = []
    
    func setupData() {
        progressList = [
            ProgressProject(title: "first"),
            ProgressProject(title: "second"),
            ProgressProject(title: "third"),
            ProgressProject(title: "fourth")
        ]
        
        finishedList = [
            FinishProject(title: "finished-first"),
            FinishProject(title: "finished-second"),
            FinishProject(title: "finished-third")
        ]
    }
    
    func fetchProgress() -> [ProgressProject] {
        return progressList
    }
    
    func fetchFinished() -> [FinishProject] {
        return finishedList
    }
    
    func addProgress(_ project: ProgressProject) {
        progressList.append(project)
    }
    
    func addFinished(_ project: FinishProject) {
        finishedList.append(project)
    }
}
