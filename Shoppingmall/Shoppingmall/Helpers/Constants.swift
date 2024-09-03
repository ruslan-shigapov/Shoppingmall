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
        enum TabBarIcons {
            static let home = UIImage(systemName: "house")
            static let catalogue = UIImage(systemName: "bag")
            static let bonus = UIImage(systemName: "gift")
            static let menu = UIImage(systemName: "menucard")
        }
    }
    // MARK: Fonts
    enum Fonts {
        static let regular = "Montserrat-Regular"
        static let medium = "Montserrat-Medium"
        static let semiBold = "Montserrat-SemiBold"
    }
    // MARK: Texts
    enum Texts {
        enum Onboarding {
            static let firstPageTitle = "Шоппинг \n и отдых"
            static let secondPageTitle = "Особые \n привилегии"
            static let thirdPageTitle = "Узнавайте первыми"
            static let fourthPageTitle = "Регистрация"
            static let thirdPageDescription = """
            Разрешите уведомления, чтобы узнавать о начисленных бонусах и специальных предложениях
            """
            static let fourthPageDescription = """
            Этот раздел доступен только авторизованным пользователям
            """
        }
        enum ButtonTitles {
            static let skip = "Пропустить"
            static let allow = "Разрешить"
            static let later = "Позже"
            static let register = "Зарегистрироваться"
            static let alreadyRegistered = "У меня уже есть аккаунт"
            static let all = "Все"
        }
        enum TabBarTitles {
            static let home = "Дом"
            static let catalogue = "Каталог"
            static let bonus = "Бонус"
            static let menu = "Меню"
        }
        enum Greetings {
            static let goodMorning = "Доброе утро!"
            static let goodAfternoon = "Добрый день!"
            static let goodEvening = "Добрый вечер!"
            static let goodNight = "Доброй ночи!"
        }
        enum BlockTitles: String, CaseIterable {
            case news = "Новости"
            case newOffers = "Новые предложения"
            case usefulInfo = "Полезная информация"
            case events = "Мероприятия"
        }
    }
}
