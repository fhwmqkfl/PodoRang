//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var goalManager: GoalManager?
    var grainCount: GrainCount = .oneWeek
    var index: Int?
    var goalStatus: GoalStatus? = .finished
    var selectedGoal: (goal: Goal, goalIndex: Int)?
    var checkDays: [Date] = []
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        findGoal()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveGoal()
    }
    
    func setup() {
        detailView.detailTableView.delegate = self
        detailView.detailTableView.dataSource = self
        setupImageGesture()
    }
    
    /// find the Goal from the goalList
    func findGoal() {
        guard let index = index,
              let goalStatus = goalStatus,
              let goalManager = goalManager
        else { return }
        
        let inProgressSegmentIndex = GoalStatus.inProgress.rawValue
        var goal: Goal
        
        if goalStatus.rawValue == inProgressSegmentIndex {
            goal = goalManager.fetchInprogress(index: index)
        } else {
            goal = goalManager.fetchFinished(index: index)
        }
        
        let startDate = goal.startDate
        let title = goal.title
        let goalList = goalManager.fetch()
        var goalListIndex: Int = 0
        
        for i in 0..<goalList.count {
            if goalList[i].title == title, goalList[i].startDate == startDate {
                goalListIndex = i
                break
            }
        }
        
        let foundGoal = goalList[goalListIndex]
        selectedGoal = (foundGoal, goalListIndex)
        checkDays = foundGoal.checkDaysToArray()
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitle]
        
        guard let selectedGoal = selectedGoal else { return }
        self.navigationItem.title = selectedGoal.goal.title
        grainCount = selectedGoal.goal.grainCount
        calculateRemainCount(checkDays.count)
        
        detailView.modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
        
        let imageName = makeImageNameText(type: selectedGoal.goal.grapeType, count: grainCount, checkDaysCount: checkDays.count)
        detailView.mainImageView.image = UIImage(named: imageName)
    }
    
    func makeImageNameText(type: Grape, count: GrainCount, checkDaysCount: Int) -> String {
        return "\(type)_\(count)_\(checkDaysCount)"
    }
    
    func saveGoal() {
        guard let goal = selectedGoal?.goal,
              let goalManager = goalManager
        else { return }
        
        goalManager.updateGoal(newCheckDays: checkDays, goal: goal)
    }
    
    func calculateRemainCount(_ checkDaysCount: Int) {
        let remainCount = grainCount.rawValue - checkDaysCount
        detailView.mainLabel.text = "Only \(remainCount) Grains to achieve"
    }
    
    func setupImageGesture() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tapGrapeImage))
        detailView.mainImageView.addGestureRecognizer(tabGesture)
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func tapGrapeImage() {
        guard let goalStatus = goalStatus, let goal = selectedGoal?.goal else { return }
        let today = Date()
        
        if goalStatus == GoalStatus.finished {
            let alertController = UIAlertController(title: "", message: "It's a finished Grape!!", preferredStyle: .alert)
            let checked = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(checked)
            present(alertController, animated: true)
        } else {
            if checkStartDate(targetDate: today, startDate: goal.startDate) {
                let stringToday = today.toStringWithoutTime()
                var stringCheckDays: [String] = []
                
                for day in checkDays {
                    stringCheckDays.append(day.toStringWithoutTime())
                }
                
                if stringCheckDays.contains(stringToday) {
                    presentChoiceAlert(title: "Remove Grain", message: "remove the painted Grain?", buttonTitle: "Remove") {
                        self.checkDays.remove(at: 0)
                        
                        DispatchQueue.main.async {
                            let imageName = self.makeImageNameText(type: goal.grapeType, count: goal.grainCount, checkDaysCount: self.checkDays.count)
                            self.calculateRemainCount(self.checkDays.count)
                            self.detailView.detailTableView.reloadData()
                            self.detailView.mainImageView.image = UIImage(named: imageName)
                        }
                    }
                } else {
                    presentChoiceAlert(title: "Paint Grain", message: "paint today's Grain?", buttonTitle: "Paint") {
                        self.checkDays.insert(today, at: 0)
                        
                        DispatchQueue.main.async {
                            let imageName = self.makeImageNameText(type: goal.grapeType, count: goal.grainCount, checkDaysCount: self.checkDays.count)
                            self.calculateRemainCount(self.checkDays.count)
                            self.detailView.detailTableView.reloadData()
                            self.detailView.mainImageView.image = UIImage(named: imageName)
                        }
                    }
                }
            } else {
                let alertController = UIAlertController(title: "", message: "It hasn't started yet", preferredStyle: .alert)
                let checked = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(checked)
                present(alertController, animated: true)
            }
        }
    }
    
    func checkStartDate(targetDate: Date, startDate: Date) -> Bool {
        return targetDate >= startDate ? true : false
    }
    
    @objc func modifyButtonClicked() {
        guard let index = selectedGoal?.goalIndex else { return }
        let addGoalVC = AddGoalViewController()
        addGoalVC.goalManger = goalManager
        addGoalVC.setupType = .modify
        addGoalVC.index = index
        self.navigationController?.pushViewController(addGoalVC, animated: true)
    }
    
    @objc func infoButtonTapped() {
        let popupVC = PopupViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: true)
    }
}

extension DetailViewController: UITableViewDelegate {}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.identifier, for: indexPath) as? DaysTableViewCell else { return UITableViewCell() }
        let checkDay = checkDays[indexPath.row].toStringWithTime()
        cell.mainLabel.text = checkDay
        cell.selectionStyle = .none
        return cell
    }
}
