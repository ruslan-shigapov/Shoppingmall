//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.08.2024.
//

import Foundation

protocol OnboardingViewModelProtocol {
    func setFirstLaunch(value: Bool)
    func requestNotificationPermission(completion: @escaping () -> Void)
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
//    TODO: replace to home screen 
//    private var isFirstLaunch: Bool {
//        UserDefaults.standard.bool(forKey: "isFirstLaunch")
//    }
    
    func setFirstLaunch(value: Bool) {
        UserDefaults.standard.setValue(value, forKey: "isFirstLaunch")
    }
    
    func requestNotificationPermission(completion: @escaping () -> Void) {
        NotificationManager.shared.requestPermission { 
            completion()
        }
    }
}
