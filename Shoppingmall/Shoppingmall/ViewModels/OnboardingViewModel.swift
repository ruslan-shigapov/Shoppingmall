//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.08.2024.
//

import Foundation

protocol OnboardingViewModelProtocol {
    func setNotFirstLaunch(value: Bool)
    func requestNotificationPermission(completion: @escaping () -> Void)
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    func setNotFirstLaunch(value: Bool) {
        UserDefaults.standard.setValue(value, forKey: "isNotFirstLaunch")
    }
    
    func requestNotificationPermission(completion: @escaping () -> Void) {
        NotificationManager.shared.requestPermission {
            completion()
        }
    }
}
