//
//  SmokeModel.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

enum SmokeModel {
  
    struct ViewModel {
        let dateDescription: String
        let cigarettes: [CigaretteModel]
    }
    
    struct CigaretteModel {
        let date: String
    }

    enum TableSection {
        case staticButtons
        case cigaretteData(ViewModel)
    }

    enum StaticButtons: Int {
        case smoke
        case breathe
        case lungsTest
        
        var title: String {
            switch self {
            case .smoke:
                "Smoke"
            case .breathe:
                "Breathe"
            case .lungsTest:
                "Test lungs"
            }
        }
        
        var subtitle: String {
            switch self {
            case .smoke:
                ""
            case .breathe:
                "Relax and try to stop thinking about smoking"
            case .lungsTest:
                "Test your lungs and see how damaged they are"
            }
        }
    }

    struct Injection {
        let coordinator: HomeBaseCoordinator
        let networkProvider: HomeNetworkProvider
    }
}
