//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var index: Int?
    var isFinished: Int?
    var selectedGoal: (goal: Goal, index: Int)?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findGoal()
        setupUI()
        setupImageGesture()
    }
    
    /// find the Goal from the goalList
    func findGoal() {
        guard let index = index, let isFinished = isFinished else { return }
        
        var goal: Goal
        if isFinished == 0 {
            goal = GoalManager.shared.fetchInprogress()[index]
        } else {
            goal = GoalManager.shared.fetchFinished()[index]
        }
        
        let startDate = goal.startDate
        let title = goal.title
        let goalList = GoalManager.shared.goalList
        var goalListIndex: Int = 0
        
        for i in 0..<goalList.count {
            if goalList[i].title == title, goalList[i].startDate == startDate {
                goalListIndex = i
                break
            }
        }
        selectedGoal = (goalList[goalListIndex], goalListIndex)
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitle]
        view.backgroundColor = .white
        
        guard let selectedGoal = selectedGoal else { return }
        title = selectedGoal.goal.title
    }
    
    func setupImageGesture() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tapGrapeImage))
        detailView.mainImageView.addGestureRecognizer(tabGesture)
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func tapGrapeImage() {
        guard let selectedGoal = selectedGoal else { return }
        let date = Date()
        GoalManager.shared.goalList[selectedGoal.index].checkDays.append(date)
        print(GoalManager.shared.goalList[selectedGoal.index].checkDays)
    }
}
