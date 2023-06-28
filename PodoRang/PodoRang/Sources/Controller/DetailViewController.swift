//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var grainCount: GrainCount = .oneWeek
    var index: Int?
    var goalStatus: GoalStatus? = .finished
    var selectedGoal: (goal: Goal, index: Int)?
    var checkDays: [Date] = []
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.detailTableView.delegate = self
        detailView.detailTableView.dataSource = self
        
        setupImageGesture()
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
    
    /// find the Goal from the goalList
    func findGoal() {
        guard let index = index, let goalStatus = goalStatus else { return }
        
        var goal: Goal
        if goalStatus.rawValue == 0 {
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
        checkDays = selectedGoal?.goal.checkDays ?? []
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
        
        guard let index = selectedGoal?.index else { return }
        self.navigationItem.title = selectedGoal?.goal.title
        grainCount = GoalManager.shared.goalList[index].grainCount
        calculateRemainCount(checkDays.count)
        
        detailView.modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
        detailView.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
    }
        
    func saveGoal() {
        guard let index = selectedGoal?.index else { return }
        GoalManager.shared.updateGoal(newCheckDays: checkDays, index: index)
    }
    
    func calculateRemainCount(_ checkDaysCount: Int) {
        let remainCount = grainCount.rawValue - checkDaysCount
        detailView.mainLabel.text = "Only \(remainCount) grapes to achieve"
    }
    
    func setupImageGesture() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tapGrapeImage))
        detailView.mainImageView.addGestureRecognizer(tabGesture)
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func tapGrapeImage() {
        let date = Date()
        let stringToday = date.toStringWithoutTime()
        var stringCheckDays: [String] = []
        
        for day in checkDays {
            stringCheckDays.append(day.toStringWithoutTime())
        }
        
        if stringCheckDays.contains(stringToday) {
            presentAlert(title: "remove grape", message: "remove the painted grape?", buttonTitle: "Remove") {
                self.checkDays.remove(at: 0)
                DispatchQueue.main.async {
                    self.calculateRemainCount(self.checkDays.count)
                    self.detailView.detailTableView.reloadData()
                }
            }
        } else {
            presentAlert(title: "paint grape", message: "paint today's grape?", buttonTitle: "Paint") {
                self.checkDays.insert(date, at: 0)
                DispatchQueue.main.async {
                    self.calculateRemainCount(self.checkDays.count)
                    self.detailView.detailTableView.reloadData()
                }
            }
        }
    }
    
    func presentAlert(title: String, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        let text: String = title
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.boldSystemFont(ofSize: 18)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: text))
        attributeString.addAttribute(.foregroundColor, value: CustomColor.textGreen, range: (text as NSString).range(of: text))
        
        let alertController = UIAlertController(title: text, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.setValue(attributeString, forKey: "attributedTitle")
        let addDate = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(addDate)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @objc func modifyButtonClicked() {
        guard let index = selectedGoal?.index else { return }
        let addGoalVC = AddGoalViewController()
        addGoalVC.setupType = .modify
        addGoalVC.index = index
        self.navigationController?.pushViewController(addGoalVC, animated: true)
    }
    
    @objc func deleteButtonClicked() {
        let alertController = UIAlertController(title: nil, message: "Are you sure to delete this goal?", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            guard let selectedGoal = self.selectedGoal else { return }
            GoalManager.shared.delete(deleteGoal: selectedGoal.goal, index: selectedGoal.index)
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(delete)
        alertController.addAction(cancel)
        present(alertController, animated: true)
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
