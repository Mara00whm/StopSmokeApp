//
//  MainCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

final class MainCoordinator: MainBaseCoordinator {

    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    var parentCoordinator: MainBaseCoordinator?

    lazy var homeCoordinator: HomeBaseCoordinator = HomeCoordinator(httpClient: httpClient)
    lazy var healthCoordinator: HealthBaseCoordinator = HealthCoordinator(httpClient: httpClient)
    lazy var statisticCoordinator: StatisticBaseCoordinator = StatisticCoordinator(httpClient: httpClient)

    lazy var rootViewController: UIViewController = MainTabBarController(coordinator: self)
    
    func start() -> UIViewController {
        let homeViewController: UIViewController = createFlowControllerFor(coordinator: homeCoordinator, andTabModel: TabChild.home.model)
        let healthViewController: UIViewController = createFlowControllerFor(coordinator: healthCoordinator, andTabModel: TabChild.health.model)
        let statisticViewController: UIViewController = createFlowControllerFor(coordinator: statisticCoordinator, andTabModel: TabChild.statistic.model)
        
        let controllers: [UIViewController] = [homeViewController, healthViewController, statisticViewController]
        
        (rootViewController as? UITabBarController)?.viewControllers = controllers
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        let flowCoordinator: Coordinator =
        switch flow {
        case .home: homeCoordinator
        case .health: healthCoordinator
        case .statistic: statisticCoordinator
        }
        
        goToFlow(flow, flowCoordinator, userData)
    }
}

//MARK: - Private methods

private extension MainCoordinator {
    
    func createFlowControllerFor(coordinator: Coordinator, andTabModel tabModel: TabChildModel) -> UIViewController {
        let viewController = coordinator.start()
        coordinator.parentCoordinator = self
        let icon: UIImage = tabModel.iconImage.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        let selectedIcon: UIImage = tabModel.selectedIconImage.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        viewController.tabBarItem = UITabBarItem(title: nil, image: icon, selectedImage: selectedIcon)
        viewController.tabBarItem.tag = tabModel.tag
        return viewController
    }
    
    func goToFlow(_ flow: AppFlow, _ coordinator: Coordinator, _ userData: [String : Any]?) {
        coordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = flow.index
    }
}
