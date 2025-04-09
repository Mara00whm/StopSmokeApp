//
//  LogInAssembly.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

final class LogInAssembly {
    
    func configurate(_ vc: LogInDisplayLogic,
                     _ injection: LogInModel.Injection) {
        let presenter: LogInPresenter = .init(injection)
        vc.presenter = presenter
        presenter.viewController = vc
    }
}
