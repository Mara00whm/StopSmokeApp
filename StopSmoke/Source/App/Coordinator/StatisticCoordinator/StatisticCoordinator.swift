//
//  StatisticCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

final class StatisticCoordinator: StatisticBaseCoordinator {

    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = .init()
    
    func start() -> UIViewController {
        let vc: UIViewController = .init()
        vc.view.backgroundColor = .red
        let rootNavigationController = UINavigationController(rootViewController: vc)
//        rootNavigationController.navigationBar.setupStyle()
        rootViewController = rootNavigationController
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        parentCoordinator?.moveTo(flow: flow, userData: userData)
    }
    
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
