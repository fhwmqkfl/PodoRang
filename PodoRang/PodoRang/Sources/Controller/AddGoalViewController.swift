//
//  AddGoalViewController.swift
//  PodoRang
//
//  Created by coco on 2023/06/05.
//

import UIKit

class AddGoalViewController: UIViewController {
    let addGoalView = AddGoalView()
    
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
        guard let title = addGoalView.goalTextField.text, let startDate = addGoalView.startDayTextField.text else { return }
        
        if !title.isEmpty, !startDate.isEmpty {
            guard let grainCountButton = addGoalView.buttonArray.filter({ $0.isSelected }).first,
                  let grapeTypeButton = addGoalView.grapeTypeArray.filter({ $0.isSelected }).first
            else {
                addGoalView.alartLabel.text = "포도알 갯수 또는 종류를 확인해주세요"
                return
            }
            let grainCount = GrainCount.allCases.filter { $0.rawValue == grainCountButton.tag }.first ?? .oneWeek
            let grapeType = Grape.allCases.filter { $0.rawValue == grapeTypeButton.tag }.first ?? .purple
            let newgoal = Goal(title: title, startDate: startDate.toDate() ?? Date(), grainCount: grainCount, grapeType: grapeType)
            GoalManager.shared.add(newgoal)
        } else {
            if title.isEmpty {
                addGoalView.goalTextField.placeholder = "목표를 입력해주세요"
                addGoalView.goalTextField.inactiveColor = CustomColor.mainPurple
            }
            if startDate.isEmpty {
                addGoalView.startDayTextField.placeholder = "시작날짜를 입력해주세요"
                addGoalView.startDayTextField.inactiveColor = CustomColor.mainPurple
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}
