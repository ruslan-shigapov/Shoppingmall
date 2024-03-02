//
//  Constants.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

enum Constants {
    // MARK: - Images
    enum Images {
        static let logo = UIImage(named: "Logo")!
    }
    // MARK: - Colors
    enum Colors {
        static let customBlue = UIColor(
            red: 61/255,
            green: 59/255,
            blue: 255/255,
            alpha: 1)
        static let customPink = UIColor(
            red: 241/255,
            green: 175/255,
            blue: 171/255,
            alpha: 1)
        static let customBlack = UIColor(
            red: 39/255,
            green: 39/255,
            blue: 39/255,
            alpha: 1)
    }
    // MARK: - Text
    enum Text {
        enum Onboarding {
            static let firstPageTitle = "Шоппинг и отдых"
            static let secondPageTitle = "Особые привилегии"
            static let thirdPageTitle = "Узнавайте первыми"
            static let fourthPageTitle = "Регистрация"
            
            static let thirdPageDescription = "Разрешите уведомления, чтобы узнавать о начисленных бонусах и специальных предложениях"
            static let fourthPageDescription = "Станьте частью сообщества Shoppingmall и получайте баллы"
            
            static let thirdPageConfirmButtonTitle = "Разрешить"
            static let fourthPageConfirmButtonTitle = "Зарегистрироваться"
            
            static let thirdPageSecondaryButtonTitle = "Позже"
            static let fourthPageSecondaryButtonTitle = "У меня уже есть аккаунт"
        }
    }
}
