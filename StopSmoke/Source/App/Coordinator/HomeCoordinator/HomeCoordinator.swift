//
//  HomeCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

final class HomeCoordinator: HomeBaseCoordinator {

    private let homeNetworkProvider: HomeNetworkProvider
    
    init(httpClient: HTTPClient) {
        self.homeNetworkProvider = .init(httpClient: httpClient)
    }

    var parentCoordinator: MainBaseCoordinator?

    lazy var rootViewController: UIViewController = .init()
    
    func start() -> UIViewController {
        let vc: HomeViewController = .init(.init(coordinator: self, networkProvider: homeNetworkProvider))
        let rootNavigationController = UINavigationController(rootViewController: vc)
        rootNavigationController.navigationBar.setupStyle()
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
    
    // MARK: - Public methods
    
    func moveToSmokeVC() {
        let vc: SmokeViewController = .init(.init(coordinator: self, networkProvider: homeNetworkProvider))
        push(controller: vc)
    }
    
    func moveToRelaxVC() {
        let vc: BreathingViewController = .init()
        push(controller: vc)
    }
}
