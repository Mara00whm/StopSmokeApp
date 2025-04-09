//
//  MainTabBarController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

final class MainTabBarController: UITabBarController, MainBaseCoordinated {
    
    var coordinator: MainBaseCoordinator?
    
    // MARK: - Init

    init(coordinator: MainBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height = tabBar.frame.size.height
        let newHeight = height + 16
        tabBar.frame = CGRect(
            origin: CGPoint(x: 0, y: view.frame.size.height - newHeight),
            size: CGSize(width: UIScreen.main.bounds.size.width, height: newHeight)
        )
        
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Private methods

private extension MainTabBarController {
    
    func setup() {
        delegate = self
        
        let appearance: UITabBarAppearance = .init()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        
        tabBar.scrollEdgeAppearance = appearance
        tabBar.standardAppearance = appearance
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelectTab tab: UITab) -> Bool {
//        true
//    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        true
    }
}
