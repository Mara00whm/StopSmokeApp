//
//  SmokeAssembly.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

final class SmokeAssembly {
    
    func configurate(_ vc: SmokeDisplayLogic,
                     _ injection: SmokeModel.Injection) {
        let presenter: SmokePresenter = .init(injection)
        vc.presenter = presenter
        presenter.viewController = vc
    }
}
