//
//  CreateAccountPresenter.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 09.04.2025.
//

protocol CreateAccountPresentationProtocol: AnyObject {
    var viewController: CreateAccountDisplayLogic? {get set}
    
    func createAccount(with model: CreateAccountModel.ViewModel)
}

final class CreateAccountPresenter: CreateAccountPresentationProtocol {
    
    // MARK: - MVP Variables
    
    weak var viewController: CreateAccountDisplayLogic?
    
    // MARK: - Managers
    
    private let provider: AuthorizationProvider
    
    // MARK: - Data Properties
    
    // MARK: - Init
    
    init(_ injection: CreateAccountModel.Injection) {
        provider = injection.provider
    }
    
    // MARK: - Delegate Methods
    
    // TODO: - Add Custom alert later
    func createAccount(with model: CreateAccountModel.ViewModel) {
        guard let userName = model.userName, !userName.isEmpty,
              let password = model.password, !password.isEmpty,
              let repeatedPassword = model.repeatedPassword,
              password == repeatedPassword else {
            viewController?.incorrectUserData()
            return
        }
        
        viewController?.startAnimation()
        Task {
            do {
                let _ = try await provider.createAccount(for: userName, password: password)
                
                await MainActor.run {
                    viewController?.accountCreated()
                    viewController?.stopAnimation()
                }
            }
            catch {
                await MainActor.run {
                    viewController?.stopAnimation()
                }
            }
        }
        
    }
}

// MARK: - Private Methods

private extension CreateAccountPresenter {
    
}
