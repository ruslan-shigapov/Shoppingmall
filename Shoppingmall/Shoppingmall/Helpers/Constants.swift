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
        static let backArrow = UIImage(named: "BackArrow")
        static let pin = UIImage(named: "Pin")
        static let illustration = UIImage(named: "Illustration")
        static let whitePin = UIImage(named: "WhitePin")
        static let forwardArrow = UIImage(named: "ForwardArrow")
        static let entrance = UIImage(named: "Entrance")
        static let map = UIImage(named: "Map")
        enum TabBarIcons {
            static let home = UIImage(named: "Home")
            static let catalogue = UIImage(named: "Bag")
            static let bonus = UIImage(named: "Gift")
            static let menu = UIImage(named: "Menu")
        }
    }
    // MARK: Fonts
    enum Fonts {
        static let regular = "Montserrat-Regular"
        static let medium = "Montserrat-Medium"
    }
    // MARK: Texts
    enum Texts {
        static let searchPlaceholder = "Поиск"
        static let noResults = "Упс..\n\n По вашему запросу\n ничего не найдено"
        static let appName = "ShoppingMall"
        enum Onboarding {
            static let firstPageTitle = "Шоппинг\n и отдых"
            static let secondPageTitle = "Особые\n привилегии"
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
            static let location = "Расположение в ТРЦ  "
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
            case offers = "Предложения за баллы"
            case usefulInfo = "Полезная информация"
            case events = "Мероприятия"
        }
        enum MenuIconNames: String, CaseIterable {
            case flash = "Flash"
            case questionPin = "QuestionPin"
            case person = "Person"
            case chat = "Chat"
            case gear = "Gear"
            case info = "Info"
        }
        enum MenuTitles: String, CaseIterable {
            case newsAndOffers = "Новости и акции"
            case howToGet = "Как добраться"
            case contacts = "Контакты"
            case chat = "Чат с ShoppingMall"
            case settings = "Настройки"
            case aboutApp = "О приложении"
        }
        enum Settings {
            static let notifications = "Уведомления"
            static let offers = "Акции в магазинах"
            static let kidsEvents = "Детские мероприятия"
            static let events = "Мероприятия в ТРЦ"
            static let loginOrRegistration = "Вход или регистрация"
        }
    }
}
