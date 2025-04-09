//
//  HomeAssembly.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 21.03.2025.
//

final class HomeAssembly {
    
    func configurate(_ vc: HomeDisplayLogic, _ injection: HomeModel.Injection) {
        let presenter: HomePresenter = .init(injection)
        vc.presenter = presenter
        presenter.viewController = vc
    }
}
