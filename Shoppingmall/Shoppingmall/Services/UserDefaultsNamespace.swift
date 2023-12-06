//
//  UserDefaultsNamespace.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 29.11.2023.
//

import Foundation

final class UserDefaultsNamespace {
    
    static let shared = UserDefaultsNamespace()
    
    private init() {}
    
    let onboardingWasViewedKey = "onboardingWasViewed"
    let deviceIdKey = "deviceId"
}
