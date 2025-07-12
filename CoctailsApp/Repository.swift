//
//  Repository.swift
//  CoctailsApp
//
//  Created by user on 29.06.2025.
//

import UIKit

protocol IRepository {
    func getRandom(count: Int) -> [RegisterUserRequest]
}


final class Repository {
    private let userList: [RegisterUserRequest] = [
        RegisterUserRequest(userName: "Bob", email: "bob123@yandex.ru", password: "12345", confirmPassword:"12345"),
        RegisterUserRequest(userName: "Bob2", email: "bob1234@yandex.ru", password: "12345", confirmPassword:"12345"),
        RegisterUserRequest(userName: "Bob3", email: "bob12345@yandex.ru", password: "12345", confirmPassword:"12345"),
        RegisterUserRequest(userName: "Bob4", email: "bob123456@yandex.ru", password: "12345", confirmPassword:"12345"),
        RegisterUserRequest(userName: "Bob5", email: "bob1234567@yandex.ru", password: "12345", confirmPassword:"12345"),
    ]
}


extension Repository: IRepository {
    func getRandom(count: Int) -> [RegisterUserRequest] {
        return userList.shuffled().prefix(count).map { $0 }
    }
}
