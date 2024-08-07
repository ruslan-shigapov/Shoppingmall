//
//  NotificationManager.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.08.2024.
//

import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestPermission(completion: @escaping () -> Void) {
        notificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { [weak self] granted, _ in
            guard let self, granted else { return }
            notificationCenter.getNotificationSettings {
                guard $0.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
