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
    
    func setupArrayData() {
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
    
    func getProgressList() -> [ProgressProject] {
        return progressList
    }
    
    func getFinishedList() -> [FinishProject] {
        return finishedList
    }
    
    func makeNewProgressProject(_ project: ProgressProject) {
        progressList.append(project)
    }
    
    func addFinisehdProject(_ project: FinishProject) {
        finishedList.append(project)
    }
}
