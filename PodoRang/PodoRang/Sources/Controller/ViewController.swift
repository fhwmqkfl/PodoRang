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
    
    var progressArray: [String] = ["a","b","c","d","e"]
    var finishedArray: [String] = ["x","y","z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        getUserData()
        tableView.dataSource = self
        tableView.delegate = self
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
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentButton.selectedSegmentIndex == 0 {
            return progressArray.count
        } else {
            return finishedArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        if segmentButton.selectedSegmentIndex == 0 {
            cell.titleLabel.text = progressArray[indexPath.row]
        } else {
            cell.titleLabel.text = finishedArray[indexPath.row]
        }
        
        return cell
    }
}
