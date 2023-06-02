//
//  SettingViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/29.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    let menuList: [String] = ["알림설정", "프로필 수정", "리뷰남기기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate {}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menuList[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menuList[indexPath.row]
            return cell
        }
    }
}
