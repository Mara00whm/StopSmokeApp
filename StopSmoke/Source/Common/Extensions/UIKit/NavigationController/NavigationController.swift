//
//  NavigationController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.clearBackButtonText()
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    func pushAndClearCenterOfNavigationStack(pushedController: UIViewController) {
        let numberOfRemovedControllers = viewControllers.count - 1
        if numberOfRemovedControllers == 0 {
            pushViewController(pushedController, animated: true)
        } else {
            pushAndRemove(pushedController: pushedController, numberOfRemovedPreviousControllers: numberOfRemovedControllers)
        }
    }
    
    func pushAndRemove(pushedController: UIViewController, numberOfRemovedPreviousControllers: Int) {
        let numberOfCurrentControllers = viewControllers.count
        var howManyDelete: Int
        if (numberOfCurrentControllers - numberOfRemovedPreviousControllers) > 0 {
            howManyDelete = numberOfRemovedPreviousControllers
        } else {
            howManyDelete = numberOfCurrentControllers - 1
        }
        var newControllers: [UIViewController] = viewControllers.dropLast(howManyDelete)
        newControllers.append(pushedController)
        setViewControllers(newControllers, animated: true)
    }
}

//MARK: Navigation with completion

extension UINavigationController {
    
    func popViewController(animated:Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
}
