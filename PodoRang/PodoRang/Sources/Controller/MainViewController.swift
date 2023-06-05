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
    
    enum SegmentIndex: Int {
        case inProgress
        case finish
    }
    
    let projectManager = ProjectManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
    
        setUI()
        getUserData()
        projectManager.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func setUI() {
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainImageView.layer.cornerRadius = mainImageView.frame.width / 2
        mainImageView.layer.borderWidth = 1
        mainImageView.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        mainImageView.backgroundColor = CustomColor.mainPurpleColor
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
    
    func loadImage(UIImage value: Data) {
        let decoded = try! PropertyListDecoder().decode(Data.self, from: value)
        let image = UIImage(data: decoded)
        mainImageView.image = image
    }
    
    func isFinished() -> Bool {
        return statusSementedControl.selectedSegmentIndex == SegmentIndex.finish.rawValue
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        mainTableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let setupVC = SetupViewController()
        self.navigationController?.pushViewController(setupVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.index = indexPath.row
        detailVC.isFinished = isFinished()
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectManager.fetch(isfinished: isFinished()).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.ddayLabel.layer.isHidden = isFinished()
        cell.titleLabel.text = "test {\(indexPath.row)}"
        cell.selectionStyle = .none
        
        return cell
    }
}
