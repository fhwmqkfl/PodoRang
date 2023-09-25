//
//  AddGoalViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit
import RealmSwift

class AddGoalViewController: UIViewController {
    let addGoalView = AddGoalView()
    var goal: Goal?
    var goalManger: GoalManager?
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
    }
    
    func setupGoal() {
        if setupType == .modify {
            guard let goal = goal else { return }
            addGoalView.setupModifyUI(goal: goal)
        }
    }
    
    func setupUI() {
        addGoalView.goalTextField.delegate = self
        addGoalView.startDayTextField.delegate = self
        
        title = "\(setupType.rawValue) Grape".localized()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: CustomColor.navigationTitle]
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
            }
        } else {
            if let goal = goal, !title.isEmpty {
                guard let grapeTypeButton = addGoalView.grapeTypeArray.filter ({ $0.isSelected }).first else { return }
                let grapeType = Grape.allCases.filter { $0.rawValue == grapeTypeButton.tag }.first ?? .purple
                goalManger.update(goal: goal, title: title, grapeType: grapeType)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonClicked() {
        guard let goal = goal,
              let goalManger = goalManger
        else { return }
        
        presentChoiceAlert(title: "", message: "Are you sure to delete this goal?", buttonTitle: "Delete", preferredStyle: .actionSheet) {
            goalManger.delete(deleteGoal: goal)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension AddGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == addGoalView.startDayLabel {
            addGoalView.newGoal.title = textField.text!
            addGoalView.checkValidation()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == addGoalView.startDayTextField {
            textField.text = Date().toStringWithoutTime()
        }
        
        return true
    }
}
