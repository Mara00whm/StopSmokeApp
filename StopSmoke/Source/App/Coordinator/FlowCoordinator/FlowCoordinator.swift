//
//  FlowCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    func moveTo(flow: AppFlow, userData: [String: Any]?)
    @discardableResult func resetToRoot(animated: Bool) -> Self
}

extension Coordinator {
    
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
    
    func push(controller: UIViewController, animated: Bool = true) {
        navigationRootViewController?.pushViewController(controller, animated: animated)
    }
    
    func pushAndClearStackCenter(controller: UIViewController) {
        navigationRootViewController?.pushAndClearCenterOfNavigationStack(pushedController: controller)
    }
    
    func pushAndRemovePrevious(controller: UIViewController, numberOfPreviousControllersToRemove: Int) {
        navigationRootViewController?.pushAndRemove(pushedController: controller, numberOfRemovedPreviousControllers: numberOfPreviousControllersToRemove)
    }
    
    func popTo(controllerClass: AnyClass) {
        navigationRootViewController?.popToViewController(ofClass: controllerClass)
    }
    
    var isLogined: Bool {
        false
//        AuthorizationManager.shared.authedUser != nil
    }
}
