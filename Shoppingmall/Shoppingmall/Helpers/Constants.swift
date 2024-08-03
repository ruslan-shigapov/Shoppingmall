//
//  Constants.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

enum Constants {
    // MARK: Fonts
    enum Fonts {
        static let regular = "Montserrat-Regular"
        static let medium = "Montserrat-Medium"
        static let semiBol = "Montserrat-SemiBold"
    }
    // MARK: Texts
    enum Texts {
        static let firstPageTitle = "Шоппинг и отдых"
        static let secondPageTitle = "Особые привилегии"
        static let thirdPageTitle = "Узнавайте первыми"
        static let fourthPageTitle = "Регистрация"
        
        static let thirdPageDescription = """
        Разрешите уведомления, чтобы узнавать о начисленных бонусах и специальных предложениях
        """
        static let fourthPageDescription = """
        Станьте частью сообщества Shoppingmall и получайте баллы
        """
        enum ButtonTitles {
            static let allow = "Разрешить"
            static let later = "Позже"
            static let register = "Зарегистрироваться"
            static let alreadyRegistered = "У меня уже есть аккаунт"
        }
    }
}
