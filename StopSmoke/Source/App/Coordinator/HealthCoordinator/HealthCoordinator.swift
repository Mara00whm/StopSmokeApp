//
//  HealthCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

final class HealthCoordinator: HealthBaseCoordinator {

    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    var parentCoordinator: (any MainBaseCoordinator)?
    lazy var rootViewController: UIViewController = .init()
    
    func start() -> UIViewController {
        let vc: HealthViewController = .init()
        let rootNavigationController = UINavigationController(rootViewController: vc)
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

final class HealthViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .red
    }
}
