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
        
        detailView.detailTableView.delegate = self
        detailView.detailTableView.dataSource = self
        
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
        let text: String = "포도알 채우기"
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.boldSystemFont(ofSize: 18)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: text)) // 폰트 적용.
        attributeString.addAttribute(.foregroundColor, value: CustomColor.textGreen, range: (text as NSString).range(of: text))
        
        let alertController = UIAlertController(title: text, message: "오늘의 포도를 채울까요?", preferredStyle: UIAlertController.Style.alert)
        alertController.setValue(attributeString, forKey: "attributedTitle")
        
        let addDate = UIAlertAction(title: "YES", style: .default) { _ in
            guard let selectedGoal = self.selectedGoal else { return }
            let date = Date()
            GoalManager.shared.goalList[selectedGoal.index].checkDays.append(date)
            self.detailView.detailTableView.reloadData()
        }
        let cancel = UIAlertAction(title: "NO", style: .destructive)
        alertController.addAction(addDate)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}

extension DetailViewController: UITableViewDelegate {}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedGoal = selectedGoal else { return 0 }
        let checkDays = GoalManager.shared.goalList[selectedGoal.index].checkDays.count
        return checkDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.identifier, for: indexPath) as? DaysTableViewCell,
            let selectedGoal = selectedGoal
        else { return UITableViewCell()}
        let checkDay = GoalManager.shared.goalList[selectedGoal.index].checkDays[indexPath.row].toString()
        cell.mainLabel.text = checkDay
        return cell
    }
}
