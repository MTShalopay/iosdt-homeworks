//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Shalopay on 29.12.2022.
//

import Foundation
import UIKit
import UserNotifications
class LocalNotificationsService: UIViewController {
    let center = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { (success, error) in
            if error != nil {
                print("ERROR: \(String(describing: error))")
            }
            if success {
                self.notificationTimeInterval(hour: 19, minute: 00, repeats: true)
            }
        }
    }
    
    private func registerUpdatesCategory() {
        let actionOk = UNNotificationAction(identifier: "actionOk", title: "Пойду", options: .destructive)
        let actionCancel = UNNotificationAction(identifier: "actionCancel", title: "Не пойду", options: .authenticationRequired)
        let testCategory = UNNotificationCategory(identifier: "updates",
                                                  actions: [actionOk, actionCancel],
                                                  intentIdentifiers: [],
                                                  options: .customDismissAction)
        center.setNotificationCategories([testCategory])
    }
    
    
    private func notificationTimeInterval(hour: Int, minute: Int, repeats: Bool) {
        let content = UNMutableNotificationContent()
        center.delegate = self
        DispatchQueue.main.async {
            content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        }
        content.categoryIdentifier = "updates"
        content.sound = .default
        content.title = "Тук тук"
        content.body = "Посмотрите последние обновления"
        var dateMatching = DateComponents()
        dateMatching.hour = hour
        dateMatching.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: repeats)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        self.center.add(request)
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
            case "actionOk": print("Taping actionOK")
            case "actionCancel": print("Tapping actionCancel")
        default:
            print("default")
        }
    }
}
