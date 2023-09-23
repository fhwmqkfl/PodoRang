//
//  SettingViewController.swift
//  PodoRang
//
//  Created by coco on 2023/05/29.
//

import UIKit
import UserNotifications
import RealmSwift

class SettingViewController: UIViewController {
    enum Menu: String {
        case alarm = "Alarm"
        case modifyProfile = "Modify Profile"
        case review = "Review"
    }
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let realm = try! Realm()
    var alarmTableViewCell: AlarmTableViewCell?
    var goalManager: GoalManager?
    var notiSetiing: Bool = false
    var menuList: [Menu] = [.alarm, .modifyProfile, .review]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalManager = GoalManager(realm: realm)
        setup()
        addNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setup() {
        self.navigationItem.title = "Setting".localized()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.separatorInset.left = 30
        settingTableView.separatorInset.right = 30
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func setupCell(cell: AlarmTableViewCell) {
        alarmTableViewCell = cell
        enterForeground()
    }
    
    func openSettingPage(_ sender: UISwitch) {
        let alertController = UIAlertController (title: "disabled notification", message: "To enable reminder,\ngo to Setting > Notifications", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) { UIApplication.shared.open(settingsUrl) }
            sender.isOn = false
        }
        
        let cancelAction = UIAlertAction(title: "Not now", style: .default) { _ in
            sender.isOn = false
        }
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func enterForeground() {
        UNUserNotificationCenter.current().getNotificationSettings { status in
            guard let alarmTableViewCell = self.alarmTableViewCell, let goalManager = self.goalManager else { return }
            self.notiSetiing = status.authorizationStatus == .authorized
            
            DispatchQueue.main.async {
                if self.notiSetiing {
                    alarmTableViewCell.alarmSwitch.isOn = UserDefaults.standard.bool(forKey: "switchState") ? true : false
                    if alarmTableViewCell.alarmSwitch.isOn {
                        // 스위치 on, 리스트X -> 삭제 필요
                        if goalManager.fetchInprogress().isEmpty {
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarm"])
                        } else {
                            // 스위치 on, 리스트O -> 알람 1개
                            UNUserNotificationCenter.current().addNotificationRequest()
                        }
                    } else {
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarm"])
                    }
                } else {
                    alarmTableViewCell.alarmSwitch.isOn = false
                }
            }
        }
    }
    
    @objc func isChanged(_ sender: UISwitch) {
        guard let goalManager = goalManager else { return }
        
        if !notiSetiing, sender.isOn {
            openSettingPage(sender)
            UserDefaults.standard.set(false, forKey: "switchState")
            return
        }
        
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")

        if sender.isOn {
            if !goalManager.fetchInprogress().isEmpty {
                UNUserNotificationCenter.current().addNotificationRequest()
            }
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarm"])
        }
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if menuList[indexPath.row] == .modifyProfile {
            guard let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
            profileVC.status = .modify
            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: true)
        } else if menuList[indexPath.row] == .review {
            if let appstoreUrl = URL(string: "https://apps.apple.com/app/id6456408239") {
                var components = URLComponents(url: appstoreUrl, resolvingAgainstBaseURL: false)
                components?.queryItems = [
                    URLQueryItem(name: "action", value: "write-review")
                ]
                guard let reviewUrl = components?.url else { return }
                UIApplication.shared.open(reviewUrl, options: [:], completionHandler: nil)
            }
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
            cell.titleLabel.text = menu.rawValue.localized()
            cell.infoLabel.text = "Send push alarm once a day at 9PM".localized()
            cell.selectionStyle = .none
            cell.alarmSwitch.addTarget(self, action: #selector(isChanged(_:)), for: .valueChanged)
            setupCell(cell: cell)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = menu.rawValue.localized()
            cell.selectionStyle = .none
            return cell
        }
    }
}
