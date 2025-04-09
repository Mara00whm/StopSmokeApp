//
//  AuthBaseCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 29.03.2025.
//

import Foundation

protocol AuthBaseCoordinator: Coordinator, AuthCoordinatorDelegate {
    func moveToCreateAccount()
}
