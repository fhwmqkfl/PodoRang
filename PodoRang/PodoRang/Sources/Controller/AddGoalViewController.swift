//
//  AddGoalViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit
import RealmSwift

enum SetupType: String {
    case add = "Add"
    case modify = "Modify"
}

class AddGoalViewController: UIViewController {
    let addGoalView = AddGoalView()
    var goal: Goal?
    var goalManger: GoalManager?
    var index: Int?
    var setupType: SetupType = .add
    
    override func loadView() {
        view = addGoalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        setupGoal()
        setupUI()
        addGoalView.saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        addGoalView.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        
        if setupType == .modify {
            guard let goal = goal else { return }
            addGoalView.setupType = .modify
            addGoalView.newGoal.grapeType = goal.grapeType
            addGoalView.newGoal.title = goal.title
        } else {
            addGoalView.setupType = .add
        }
    }
    
    func setupGoal() {
        guard let goalManger = goalManger, let index = index else { return }
        goal = goalManger.fetchGoal(index: index)
    }
    
    func setupUI() {
        title = "\(setupType.rawValue) Grape"
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: CustomColor.navigationTitle]
        view.backgroundColor = .white
        
        if setupType == .modify {
            guard let goal = goal else { return }
            addGoalView.goalTextField.text = goal.title
            addGoalView.startDayTextField.text = goal.startDate.toStringWithoutTime()
            addGoalView.startDayTextField.isUserInteractionEnabled = false
            addGoalView.startDayTextField.textColor = .systemGray2
            let grainCount = goal.grainCount
            
            if grainCount == GrainCount.oneWeek {
                addGoalView.oneWeekButton.isSelected = true
                addGoalView.oneWeekButton.backgroundColor = CustomColor.lightPurple
            } else if grainCount == GrainCount.twoWeeks {
                addGoalView.twoWeeksButton.isSelected = true
                addGoalView.twoWeeksButton.backgroundColor = CustomColor.lightPurple
            } else {
                addGoalView.threeWeeksButton.isSelected = true
                addGoalView.threeWeeksButton.backgroundColor = CustomColor.lightPurple
            }
            
            addGoalView.oneWeekButton.isEnabled = false
            addGoalView.twoWeeksButton.isEnabled = false
            addGoalView.threeWeeksButton.isEnabled = false
            addGoalView.deleteButton.isHidden = false
            
            let colorButton = addGoalView.grapeTypeArray[goal.grapeType.rawValue]
            
            if colorButton == addGoalView.purpleButton {
                addGoalView.purpleButton.isSelected = true
                addGoalView.redButton.isEnabled = false
                addGoalView.greenButton.isEnabled = false
            } else if colorButton == addGoalView.redButton {
                addGoalView.redButton.isSelected = true
                addGoalView.purpleButton.isEnabled = false
                addGoalView.greenButton.isEnabled = false
            } else {
                addGoalView.greenButton.isSelected = true
                addGoalView.redButton.isEnabled = false
                addGoalView.purpleButton.isEnabled = false
            }
        }
    }

    @objc func saveButtonClicked() {
        guard let title = addGoalView.goalTextField.text,
              let startDate = addGoalView.startDayTextField.text,
              let goalManger = goalManger
        else { return }
        
        if setupType == .add {
            if !title.isEmpty, !startDate.isEmpty {
                guard let grainCountButton = addGoalView.buttonArray.filter ({ $0.isSelected }).first,
                      let grapeTypeButton = addGoalView.grapeTypeArray.filter ({ $0.isSelected }).first
                else { return }
                
                let grainCount = GrainCount.allCases.filter { $0.rawValue == grainCountButton.tag }.first ?? .none
                let grapeType = Grape.allCases.filter { $0.rawValue == grapeTypeButton.tag }.first ?? .none
                let newGoal = Goal(title: title, startDate: startDate.toDate() ?? Date(), grainCount: grainCount, grapeType: grapeType)
                goalManger.add(newGoal)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if let goal = goal, !title.isEmpty {
                guard let grapeTypeButton = addGoalView.grapeTypeArray.filter ({ $0.isSelected }).first else { return }
                let grapeType = Grape.allCases.filter { $0.rawValue == grapeTypeButton.tag }.first ?? .purple
                goalManger.update(goal: goal, title: title, grapeType: grapeType)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func deleteButtonClicked() {
        guard let goal = goal,
              let goalManger = goalManger
        else { return }
        let alertController = UIAlertController(title: "", message: "Are you sure to delete this goal?", preferredStyle: .actionSheet)
        let deleteGoal = UIAlertAction(title: "Delete", style: .destructive) { _ in
            goalManger.delete(deleteGoal: goal)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(deleteGoal)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}
