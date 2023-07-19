//
//  SettingViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/29.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    enum Menu: Int {
        case alarmSetting
        case modifyProfile
        case appstoreReview
    }
    
    let menuList: [String] = ["Alarm", "Modify Profile", "Review"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        title = "Setting"
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.separatorInset.left = 30
        settingTableView.separatorInset.right = 30
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == Menu.modifyProfile.rawValue {
            guard let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
            profileVC.status = .modify
            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: true)
        }
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = menuList[indexPath.row]
        
        if indexPath.row == Menu.alarmSetting.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menu
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menu
            cell.selectionStyle = .none
            return cell
        }
    }
}
