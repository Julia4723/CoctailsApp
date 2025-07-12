//
//  ModelManager.swift
//  CoctailsApp
//
//  Created by user on 30.06.2025.
//

import UIKit

protocol IModelManager {
    func getRegisterUser() -> [RegisterUserRequest]
    func getLoginUser() -> [LoginUserRequest]
}


final class ModelManagerStub: IModelManager {
    
    private var registerUserList: [RegisterUserRequest] = []
    private var loginUserList: [LoginUserRequest] = []
    
    func getRegisterUser() -> [RegisterUserRequest] {
        registerUserList
    }
    
    func getLoginUser() -> [LoginUserRequest] {
        loginUserList
    }
    
    
}
