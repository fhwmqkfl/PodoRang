//
//  SettingViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/29.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    enum Menu: String {
        case alarm = "Alarm"
        case modifyProfile = "Modify Profile"
        case review = "Review"
    }
    
    var menuList: [Menu] = []
    var hideAlarmMenu: Bool = true
    
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
        menuList = hideAlarmMenu ? [.modifyProfile, .review] : [.alarm, .modifyProfile, .review]
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if menuList[indexPath.row] == .modifyProfile {
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
        
        if menu == .alarm {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menu.rawValue
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menu.rawValue
            cell.selectionStyle = .none
            return cell
        }
    }
}
