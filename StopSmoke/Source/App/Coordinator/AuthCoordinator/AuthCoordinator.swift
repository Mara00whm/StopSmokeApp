//
//  AuthCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 29.03.2025.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authSuccessed()
}

final class AuthCoordinator: AuthBaseCoordinator {

    private let provider: AuthorizationProvider

    init(httpClient: HTTPClient) {
        provider = .init(httpClient: httpClient)
    }

    var onAuthSuccess: (() -> Void)?

    var parentCoordinator: (any MainBaseCoordinator)?
    lazy var rootViewController: UIViewController = .init()
    
    func start() -> UIViewController {
        let vc: LogInViewController = .init(.init(coordinator: self, provider: provider))
        let rootNavigationController = UINavigationController(rootViewController: vc)
        rootNavigationController.navigationBar.setupStyle()
        rootViewController = rootNavigationController
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]?) {}
    
    func moveToCreateAccount() {
        let vc: CreateAccountViewController = .init(.init(provider: provider))
        push(controller: vc)
    }
}

extension AuthCoordinator: AuthCoordinatorDelegate {

    func authSuccessed() {
        onAuthSuccess?()
    }
}
