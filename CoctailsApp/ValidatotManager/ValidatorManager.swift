//
//  ValidatorManager.swift
//  CoctailsApp
//
//  Created by user on 02.07.2025.
//

import UIKit

enum EmailValidatorError: Error {
    case empty
    case invalidFormat
    case domainNotAllowed
}

final class ValidatorManager {
    static func validateEmail(_ email: String) -> Result<Bool, EmailValidatorError> {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email.isEmpty {
            return .failure(.empty)
        }
        
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            return .failure(.invalidFormat)
        }
        
        let allowedDomains = ["mail.ru", "yandex.ru", "gmail.com", "ita.com", "i.ru"]
        guard let emailDomain = email.split(separator: "@").last,
              allowedDomains.contains(String(emailDomain)) else {
            return .failure(.domainNotAllowed)
        }
        
        return .success(true)
    }
    
    static func isValidUserName(for userName: String) -> Bool {
        let userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let userNameRegex = "\\w{4,24}"
        let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
        return userNamePred.evaluate(with: userName)
    }
    
    static func isPasswordValid(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
}
