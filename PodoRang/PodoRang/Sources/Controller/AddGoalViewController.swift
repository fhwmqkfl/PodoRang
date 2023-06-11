//
//  AddGoalViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit

class AddGoalViewController: UIViewController {
    let addGoalView = AddGoalView()
    let goalManager = GoalManager.shared
    
    override func loadView() {
        view = addGoalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addGoalView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    func setupUI() {
        title = "목표 작성하기"
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: CustomColor.navigationTitle]

        view.backgroundColor = .white
    }
    
    @objc func saveButtonClicked() {
        var newGoal = Goal()
        // 목표
        if let title = addGoalView.goalTextField.text, title != "" {
            newGoal.title = title
        } else {
            addGoalView.goalTextField.placeholder = "목표를 입력해주세요"
            addGoalView.goalTextField.inactiveColor = CustomColor.mainPurple
        }
        // 시작날짜
        if let date = addGoalView.startDayTextField.text?.toDate() {
            newGoal.startDate = date
        } else {
            addGoalView.startDayTextField.placeholder = "시작날짜를 입력해주세요"
            addGoalView.startDayTextField.inactiveColor = CustomColor.mainPurple
        }
    }
}
