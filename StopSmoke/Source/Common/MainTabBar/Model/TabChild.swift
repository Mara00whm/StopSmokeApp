//
//  TabChild.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

enum TabChild: Int {
    case home
    case health
    case statistic
    
    var model: TabChildModel {
        switch self {
        case .home: HomeTabModel()
        case .health: HealthTabModel()
        case .statistic: StatisticTabModel()
        }
    }
    
    var flow: AppFlow {
        switch self {
        case .home: .home(.main)
        case .health: .health(.main)
        case .statistic: .statistic(.main)
        }
    }
}

protocol TabChildModel {
    var iconImage: UIImage { get }
    var selectedIconImage: UIImage { get }
    var tag: Int { get }
}

struct HomeTabModel: TabChildModel {
    let iconImage: UIImage = .homeNotSelectedImage
    let selectedIconImage: UIImage = .homeSelectedImage
    let tag: Int = TabChild.home.rawValue
}

struct HealthTabModel: TabChildModel {
    let iconImage: UIImage = .heartNotSelectedImage
    let selectedIconImage: UIImage = .heartSelectedImage
    let tag: Int = TabChild.health.rawValue
}

struct StatisticTabModel: TabChildModel {
    let iconImage: UIImage = .statisticNotSelectedImage
    let selectedIconImage: UIImage = .statisticSelectedImage
    let tag: Int = TabChild.statistic.rawValue
}
