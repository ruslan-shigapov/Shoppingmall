//
//  Constants.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

enum Constants {
    // MARK: Images
    enum Images {
        static let appName = UIImage(named: "AppName")
    }
    // MARK: Fonts
    enum Fonts {
        static let regular = "Montserrat-Regular"
        static let medium = "Montserrat-Medium"
        static let semiBol = "Montserrat-SemiBold"
    }
    // MARK: Texts
    enum Texts {
        static let firstPageTitle = "Шоппинг \n и отдых"
        static let secondPageTitle = "Особые \n привилегии"
        static let thirdPageTitle = "Узнавайте первыми"
        static let fourthPageTitle = "Регистрация"
        static let thirdPageDescription = """
        Разрешите уведомления, чтобы узнавать о начисленных бонусах и специальных предложениях
        """
        static let fourthPageDescription = """
        Станьте частью сообщества Shoppingmall и получайте баллы
        """
        enum ButtonTitles {
            static let skip = "Пропустить"
            static let allow = "Разрешить"
            static let later = "Позже"
            static let register = "Зарегистрироваться"
            static let alreadyRegistered = "У меня уже есть аккаунт"
        }
    }
}
