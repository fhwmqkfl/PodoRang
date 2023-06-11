//
//  AddProjectViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit

class AddProjectViewController: UIViewController {
    let addProjectView = AddProjectView()
    let goalManager = GoalManager.shared
    
    override func loadView() {
        view = addProjectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addProjectView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
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
        if let title = addProjectView.goalTextField.text, title != "" {
            newGoal.title = title
        } else {
            addProjectView.goalTextField.placeholder = "목표를 입력해주세요"
            addProjectView.goalTextField.inactiveColor = CustomColor.mainPurple
        }
        // 시작날짜
        if let date = addProjectView.startDayTextField.text?.toDate() {
            newGoal.startDate = date
        } else {
            addProjectView.startDayTextField.placeholder = "시작날짜를 입력해주세요"
            addProjectView.startDayTextField.inactiveColor = CustomColor.mainPurple
        }
    }
}
