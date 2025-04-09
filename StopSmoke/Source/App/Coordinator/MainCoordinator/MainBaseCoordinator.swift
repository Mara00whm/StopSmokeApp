//
//  MainCoordinator.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import Foundation

protocol MainBaseCoordinator: Coordinator {
    var homeCoordinator: HomeBaseCoordinator { get }
    var healthCoordinator: HealthBaseCoordinator { get }
    var statisticCoordinator: StatisticBaseCoordinator { get }
}

protocol MainBaseCoordinated {
    var coordinator: MainBaseCoordinator? { get }
}

protocol HomeBaseCoordinated {
    var coordinator: HomeBaseCoordinator? { get }
}

protocol HealthBaseCoordinated {
    var coordinator: HealthBaseCoordinator? { get }
}

protocol StatisticBaseCoordinated {
    var coordinator: StatisticBaseCoordinator? { get }
}
