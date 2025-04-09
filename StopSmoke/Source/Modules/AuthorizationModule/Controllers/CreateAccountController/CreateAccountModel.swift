//
//  CreateAccountModel.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 09.04.2025.
//

enum CreateAccountModel {
  
    struct ViewModel {
        let userName: String?
        let password: String?
        let repeatedPassword: String?
    }
    
    struct Injection {
        let provider: AuthorizationProvider
    }
}
