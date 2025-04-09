//
//  HomePresenter.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 21.03.2025.
//

protocol HomePresentationProtocol: AnyObject {
    var viewController: HomeDisplayLogic? {get set}
    
    func smokeTapped()
}

final class HomePresenter: HomePresentationProtocol {
    
    // MARK: - MVP Variables
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Managers
    
    private let coordiantor: HomeBaseCoordinator
    
    // MARK: - Logic Variables
    
    // MARK: - Data Properties
    
    // MARK: - Init
    
    init(_ injection: HomeModel.Injection) {
        coordiantor = injection.coordinator
    }
    
    // MARK: - Delegate Methods
    
    func smokeTapped() {
        coordiantor.moveToSmokeVC()
    }
}

// MARK: - Private Methods

private extension HomePresenter {
    
}
