//
//  DetailViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/28.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var grainCount: Int = 7
    var index: Int?
    var isFinished: Int?
    var selectedGoal: (goal: Goal, index: Int)?
    var checkDays: [Date] = []
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveGoal()
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
        checkDays = selectedGoal?.goal.checkDays ?? []
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = CustomColor.navigationTitle
        navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor : CustomColor.navigationTitle]
        view.backgroundColor = .white
        
        guard let index = selectedGoal?.index else { return }
        title = selectedGoal?.goal.title
        grainCount = GoalManager.shared.goalList[index].grainCount.rawValue
        calculateRemainCount(checkDays.count)
    }
    
    func saveGoal() {
        guard let index = selectedGoal?.index else { return }
        if checkDays != GoalManager.shared.goalList[index].checkDays {
            let isAppended = checkDays.count > GoalManager.shared.goalList[index].checkDays.count
            if isAppended {
                GoalManager.shared.addCheckDay(checkDays, index)
            } else {
                GoalManager.shared.removeCheckDay(checkDays, index)
            }
        }
    }
    
    func calculateRemainCount(_ checkDaysCount: Int) {
        let remainCount = grainCount - checkDaysCount
        detailView.mainLabel.text = "앞으로 \(remainCount)개의 포도알을 채우면 완성이에요"
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
            presentAlert(title: "포도알 삭제하기", message: "채워진 포도를 지울까요?", buttonTitle: "삭제") {
                self.checkDays.remove(at: 0)
                DispatchQueue.main.async {
                    self.calculateRemainCount(self.checkDays.count)
                    self.detailView.detailTableView.reloadData()
                }
            }
        } else {
            presentAlert(title: "포도알 채우기", message: "오늘의 포도를 채울까요?", buttonTitle: "추가") {
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
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        alertController.addAction(addDate)
        alertController.addAction(cancel)
        present(alertController, animated: true)
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
        return cell
    }
}
