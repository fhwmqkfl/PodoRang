//
//  SettingViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/29.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate {}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as? SettingTableViewCell else { return UITableViewCell()}
        if indexPath.row == SettingMenu.alarm.rawValue {
            cell.mainLabel.text = "알림설정"
        } else if indexPath.row == SettingMenu.modifyProfile.rawValue {
            cell.mainLabel.text = "프로필 수정"
        } else {
            cell.mainLabel.text = "리뷰남기기"
        }
        return cell
    }
}
