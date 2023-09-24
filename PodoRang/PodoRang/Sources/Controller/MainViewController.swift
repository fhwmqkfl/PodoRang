//
//  MainViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/22.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var statusSementedControl: UISegmentedControl!
    
    let realm = try! Realm()
    var goalManager: GoalManager?
    var inProgressList: [Goal] = []
    var finishedList: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    func setup() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        setUI()
        goalManager = GoalManager(realm: realm)
        statusSementedControl.addUnderlineForSelectedSegment()
    }
    
    func setUI() {
        mainTableView.rowHeight = 100
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
    
    func refresh() {
        guard let goalManager = goalManager else { return }
        getUserData()
        goalManager.updateGoalStatus()
        refreshGoalLists()
        mainTableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    func getUserData() {
        if let userName = UserDefaults.standard.string(forKey: UserDefaultsKey.userName), let userThumbnail = UserDefaults.standard.data(forKey: UserDefaultsKey.userThumbnail) {
            mainLabel.text = "Hello, %@".localized(with: userName)
            loadImage(UIImage: userThumbnail)
        } else {
            let alertController = UIAlertController(title: "", message: "Please set up your profile and access again".localized(), preferredStyle: UIAlertController.Style.alert)
            let checked = UIAlertAction(title: "OK", style: .default) { _ in
                guard let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
                profileVC.modalPresentationStyle = .fullScreen
                self.present(profileVC, animated: true)
            }
            
            alertController.addAction(checked)
            present(alertController, animated: true)
        }
    }
    
    func loadImage(UIImage value: Data) {
        let decoded = try! PropertyListDecoder().decode(Data.self, from: value)
        let image = UIImage(data: decoded)
        mainImageView.image = image
    }
    
    func refreshGoalLists() {
        guard let goalManager = goalManager else { return }
        finishedList = goalManager.fetchFinished()
        inProgressList = goalManager.fetchInprogress()
    }
    
    func makeDdayText(dday: Int?, targetDate: Date, startDate: Date) -> String {
        if let dday = dday {
            let text = targetDate >= startDate ? "D-\(dday)" : "Unstarted".localized()
            return text
        }
        
        return "Finished".localized()
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        refresh()
        statusSementedControl.changeUnderlinePosition()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let setupVC = AddGoalViewController()
        setupVC.goalManger = goalManager
        self.navigationController?.pushViewController(setupVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.goalManager = goalManager
        detailVC.goalStatus = GoalStatus(rawValue: statusSementedControl.selectedSegmentIndex)
        detailVC.index = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isFinished = statusSementedControl.selectedSegmentIndex == GoalStatus.inProgress.rawValue ? inProgressList.count : finishedList.count
        return isFinished
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let goalManager = goalManager else { return UITableViewCell() }
        let isFinished = statusSementedControl.selectedSegmentIndex == GoalStatus.finished.rawValue
        var goal: Goal
        
        if isFinished {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FinishedCell.identifier) as? FinishedCell else { return UITableViewCell() }
            goal = finishedList[indexPath.row]
            cell.selectionStyle = .none
            cell.titleLabel.text = goal.title
            
            if goal.isSuccessed {
                cell.isSuccessImage.image = UIImage(named: "success")
            } else {
                cell.isSuccessImage.image = UIImage(named: "failed")
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }
            goal = inProgressList[indexPath.row]
            let date = Date()
            let dday = goalManager.calculateDday(goal: goal, targetDate: date)
            let ddayText = makeDdayText(dday: dday, targetDate: date, startDate: goal.startDate)
            cell.selectionStyle = .none
            cell.ddayLabel.text = ddayText
            cell.titleLabel.text = goal.title
            cell.ddayLabel.isHidden = isFinished
            
            return cell
        }
    }
}
