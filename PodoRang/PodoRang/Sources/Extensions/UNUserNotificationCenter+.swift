//
//  UNUserNotificationCenter+.swift
//  PodoRang
//
//  Created by coco on 2023/09/14.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequest() {
        let content = UNMutableNotificationContent()
        let formmater = DateFormatter()
        var date = DateComponents()
        content.title = "Did you achieve today's goal?".localized()
        content.sound = .default
        date.hour = 21
        date.minute = 00
        formmater.dateFormat = "K"
        formmater.dateFormat = "mm"
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
