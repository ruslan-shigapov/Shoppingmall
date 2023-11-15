//
//  Constants.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 09.11.2023.
//

import UIKit

enum Constants {
    
    enum Colors {
        
        static let deepBlue = UIColor(named: "DeepBlue")
    }
    
    enum Text {
        
        enum Onboarding {
            
            static let firstPageTitle = "Шоппинг и отдых"
            static let secondPageTitle = "Особые привилегии"
            static let thirdPageTitle = "Узнавайте первыми"
            static let fourthPageTitle = "Регистрация"
            
            static let thirdPageDescription = "Разрешите уведомления, чтобы узнавать о начисленных бонусах и специальных предложениях"
            static let fourthPageDescription = "Станьте частью сообщества Shoppingmall и получайте баллы"
        }
        
        static let loginTitle = "Авторизация"
        static let loginSign = "Введите номер телефона"
        static let loginInfo = "На него будет отправлен одноразовый код"
        
        enum ButtonTitle {
            
            static let allow = "Разрешить"
            static let sooner = "Позже"
            static let register = "Зарегистрироваться"
            static let alreadyRegistered = "У меня уже есть аккаунт"
            static let skip = "Пропустить"
            static let done = "Готово"
        }
        
        static let afternoon = "Добрый день!"
    }
    
    enum Images {
        
        static let logo = UIImage(named: "Logo")
        static let shoppingAndRest = UIImage(named: "Onboarding1") // delete
    }
}
