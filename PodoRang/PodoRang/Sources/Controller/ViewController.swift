//
//  ViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    let dataManager = DataManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        getUserData()
        tableView.dataSource = self
        tableView.delegate = self
        dataManager.setupArrayData()
    }
    
    func setUI() {
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainImage.layer.cornerRadius = mainImage.frame.width / 2
        mainImage.layer.borderWidth = 1
        mainImage.layer.borderColor = CustomColor.mainPurpleColor.cgColor
        mainImage.backgroundColor = CustomColor.mainPurpleColor
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
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
        mainImage.image = image
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        // 랜덤하게 값 추가하게 처리
        let random = Int.random(in: 0...1)

        if random == 0 {
            let newProject = ProgressProject(title: "new")
            dataManager.makeNewProgressProject(newProject)
        } else {
            let finishedProject = FinishProject(title: "finished-new")
            dataManager.addFinisehdProject(finishedProject)
        }
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.index = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentButton.selectedSegmentIndex == SegmentIndex.inProgres.rawValue {
            return dataManager.getProgressList().count
        } else {
            return dataManager.getFinishedList().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        if segmentButton.selectedSegmentIndex == SegmentIndex.inProgres.rawValue {
            cell.titleLabel.text = "test {\(indexPath.row)}"
            cell.ddayLabel.layer.isHidden = false
        } else {
            cell.titleLabel.text = "test {\(indexPath.row)}"
            cell.ddayLabel.layer.isHidden = true
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
