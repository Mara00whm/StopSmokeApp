//
//  CreateAccountAssembly.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 09.04.2025.
//

final class CreateAccountAssembly {
    
    func configurate(_ vc: CreateAccountDisplayLogic,
                     _ injection: CreateAccountModel.Injection) {
        let presenter: CreateAccountPresenter = .init(injection)
        vc.presenter = presenter
        presenter.viewController = vc
    }
}
