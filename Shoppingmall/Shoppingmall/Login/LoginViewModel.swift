//
//  LoginViewModel.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 08.11.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func replaceCharactersOf(
        text: String?,
        in range: NSRange,
        withReplacement string: String,
        completion: (String) -> Void
    )
    func format(phoneNumber: String) -> String
}

final class LoginViewModel: LoginViewModelProtocol {
    
    func replaceCharactersOf(
        text: String?,
        in range: NSRange,
        withReplacement string: String,
        completion: (String) -> Void
    ) {
        guard let text else { return }
        let newText = (text as NSString).replacingCharacters(
            in: range,
            with: string
        )
        completion(newText)
    }
    
    /// Форматирование номера телефона под стандартную маску
    func format(phoneNumber: String) -> String {
        let mask = "+X (XXX) XXX XX XX"
        let cleanPhoneNumber = phoneNumber.components(
            separatedBy: .decimalDigits.inverted
        ).joined()
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        for element in mask where index < cleanPhoneNumber.endIndex {
            if element == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(element)
            }
        }
        return result
    }
}
