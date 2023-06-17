//
//  MainViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/22.
//

import UIKit

class MainViewController: UIViewController {
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
        getUserData()
        GoalManager.shared.setupData()
        refreshGoalLists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserData()
        tabBarController?.tabBar.isHidden = false
        mainTableView.reloadData()
    }
    
    func setUI() {
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
            mainLabel.text = "안녕하세요 \(userName)님"
            loadImage(UIImage: userImage)
        } else {
            print("데이터를 가져오는데 실패했습니다")
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
        mainTableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let setupVC = AddGoalViewController()
        self.navigationController?.pushViewController(setupVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 진행/완료 여부 & 그 안에서 몇번째인지 인덱스 정보
        let detailVC = DetailViewController()
        detailVC.isFinished = statusSementedControl.selectedSegmentIndex
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
        }
        
        cell.titleLabel.text = goal.title
        cell.ddayLabel.isHidden = isFinished
        cell.selectionStyle = .none
        
        return cell
    }
}
