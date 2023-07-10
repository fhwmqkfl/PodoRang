//
//  MainViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var alarmButton: UIBarButtonItem!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var statusSementedControl: UISegmentedControl!
    
    var inProgressList: [Goal] = []
    var finishedList: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        setUI()
        GoalManager.shared.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserData()
        tabBarController?.tabBar.isHidden = false
        GoalManager.shared.updateGoalStatus()
        refreshGoalLists()
        mainTableView.reloadData()
    }
    
    func setUI() {
        alarmButton.isHidden = true
        mainTableView.separatorInset.left = 30
        mainTableView.separatorInset.right = 30
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainImageView.layer.cornerRadius = mainImageView.frame.width / 2
        mainImageView.layer.borderWidth = 1
        mainImageView.layer.borderColor = CustomColor.mainPurple.cgColor
        mainImageView.backgroundColor = CustomColor.mainPurple
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
    }
    
    func getUserData() {
        if let userName = UserDefaults.standard.string(forKey: "userName"), let userImage = UserDefaults.standard.data(forKey: "userImage") {
            mainLabel.text = "Hello, \(userName)"
            loadImage(UIImage: userImage)
        } else {
            let alertController = UIAlertController(title: "", message: "Please set up your profile and access again", preferredStyle: UIAlertController.Style.alert)
            let checked = UIAlertAction(title: "OK", style: .default) { _ in
                guard let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
                profileVC.modalPresentationStyle = .fullScreen
                self.present(profileVC, animated: true)
            }
            alertController.addAction(checked)
            present(alertController, animated: true)
        }
    }
    
    func refreshGoalLists() {
        finishedList = GoalManager.shared.fetchFinished()
        inProgressList = GoalManager.shared.fetchInprogress()
    }
    
    func loadImage(UIImage value: Data) {
        let decoded = try! PropertyListDecoder().decode(Data.self, from: value)
        let image = UIImage(data: decoded)
        mainImageView.image = image
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        GoalManager.shared.updateGoalStatus()
        refreshGoalLists()
        mainTableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let setupVC = AddGoalViewController()
        self.navigationController?.pushViewController(setupVC, animated: true)
    }
    
    func makeDdayText(dday: Int, targetDate: Date, startDate: Date) -> String {
        if dday >= 0 {
            if targetDate >= startDate {
                return "D-\(dday)"
            } else {
                return "UnStarted"
            }
        } else {
            return "Finished"
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.goalStatus = GoalStatus(rawValue: statusSementedControl.selectedSegmentIndex)
        detailVC.index = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statusSementedControl.selectedSegmentIndex == GoalStatus.inProgress.rawValue {
            return inProgressList.count
        } else {
            return finishedList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }
        let isFinished = statusSementedControl.selectedSegmentIndex == GoalStatus.finished.rawValue
        var goal: Goal
        
        if isFinished {
            goal = finishedList[indexPath.row]
        } else {
            goal = inProgressList[indexPath.row]
            let date = Date()
            let dday = GoalManager.shared.calculateDday(goal: goal, targetDate: date)
            let ddayText = makeDdayText(dday: dday, targetDate: date, startDate: goal.startDate)
            cell.ddayLabel.text = ddayText
        }
        
        cell.titleLabel.text = goal.title
        cell.ddayLabel.isHidden = isFinished
        cell.selectionStyle = .none
        return cell
    }
}
