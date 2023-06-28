//
//  AddGoalViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit

class AddGoalViewController: UIViewController {
    enum SetupType: String {
        case add = "Add"
        case modify = "Modify"
    }
    
    let addGoalView = AddGoalView()
    var goal: Goal?
    var index: Int?
    var setupType: SetupType = .add
    
    override func loadView() {
        view = addGoalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoal()
        setupUI()
        addGoalView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    func setupGoal() {
        guard let index = index else { return }
        goal = GoalManager.shared.goalList[index]
    }
    
    func setupUI() {
        title = "\(setupType.rawValue) Goal"
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: CustomColor.navigationTitle]
        view.backgroundColor = .white
        
        // TODO: change UI/UX
        if  setupType == .modify {
            guard let goal = goal else { return }
            addGoalView.goalTextField.text = goal.title
            addGoalView.alartLabel.text = "You can only modify Goal title!"
            addGoalView.startDayTextField.text = goal.startDate.toStringWithoutTime()
            addGoalView.startDayTextField.isUserInteractionEnabled = false
            addGoalView.startDayTextField.textColor = .systemGray2
            addGoalView.oneWeekButton.isEnabled = false
            addGoalView.oneWeekButton.backgroundColor = .systemGray5
            addGoalView.twoWeeksButton.isEnabled = false
            addGoalView.twoWeeksButton.backgroundColor = .systemGray5
            addGoalView.threeWeeksButton.isEnabled = false
            addGoalView.threeWeeksButton.backgroundColor = .systemGray5
            addGoalView.redButton.isEnabled = false
            addGoalView.greenButton.isEnabled = false
            addGoalView.purpleButton.isEnabled = false
        }
    }
    
    @objc func saveButtonClicked() {
        if setupType == .add {
            guard let title = addGoalView.goalTextField.text, let startDate = addGoalView.startDayTextField.text else { return }
            
            if !title.isEmpty, !startDate.isEmpty {
                guard
                    let grainCountButton = addGoalView.buttonArray.filter ({ $0.isSelected }).first,
                    let grapeTypeButton = addGoalView.grapeTypeArray.filter ({ $0.isSelected }).first
                else {
                    addGoalView.alartLabel.text = "Check Count or Type of Grape"
                    return
                }
                let grainCount = GrainCount.allCases.filter { $0.rawValue == grainCountButton.tag }.first ?? .oneWeek
                let grapeType = Grape.allCases.filter { $0.rawValue == grapeTypeButton.tag }.first ?? .purple
                let newgoal = Goal(title: title, startDate: startDate.toDate() ?? Date(), grainCount: grainCount, grapeType: grapeType)
                GoalManager.shared.add(newgoal)
                self.navigationController?.popViewController(animated: true)
            } else {
                if title.isEmpty {
                    addGoalView.goalTextField.placeholder = "Enter Goal"
                    addGoalView.goalTextField.inactiveColor = CustomColor.mainPurple
                }
                if startDate.isEmpty {
                    addGoalView.startDayTextField.placeholder = "Enter Startdate"
                    addGoalView.startDayTextField.inactiveColor = CustomColor.mainPurple
                }
            }
        } else {
            guard let title = addGoalView.goalTextField.text, let index = index else { return }
            
            if var goal = goal, !title.isEmpty {
                goal.title = title
                GoalManager.shared.update(goal: goal, index: index)
                self.navigationController?.popViewController(animated: true)
            } else {
                addGoalView.goalTextField.placeholder = "Enter Goal"
                addGoalView.goalTextField.inactiveColor = CustomColor.mainPurple
            }
        }
    }
}
