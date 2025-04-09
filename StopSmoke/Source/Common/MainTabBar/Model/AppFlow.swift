//
//  AppFlow.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

enum AppFlow {
    case home(HomeScreen)
    case health(HealthScreen)
    case statistic(StatisticScreen)
    
}

enum HomeScreen {
    case main
}

enum HealthScreen {
    case main
}

enum StatisticScreen {
    case main
}


extension AppFlow {
    
    var tabChildModel: TabChildModel {
        switch self {
        case .home: TabChild.home.model
        case .health: TabChild.health.model
        case .statistic: TabChild.statistic.model
        }
    }
    
    var index: Int {
        switch self {
        case .home: TabChild.home.rawValue
        case .health: TabChild.health.rawValue
        case .statistic: TabChild.statistic.rawValue
        }
    }
}
