//
//  LogInPresenter.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

protocol LogInPresentationProtocol: AnyObject {
    var viewController: LogInDisplayLogic? {get set}
    
    func tryToLogin(username: String?, password: String?)
    func tryToAuthorize()
    func moveToSignUp()
}

final class LogInPresenter: LogInPresentationProtocol {
    
    // MARK: - MVP Variables
    
    weak var viewController: LogInDisplayLogic?
    
    // MARK: - Managers
    
    private let provider: AuthorizationProvider
    private let coordinator: AuthBaseCoordinator
    
    // MARK: - Init
    
    init(_ injection: LogInModel.Injection) {
        provider = injection.provider
        coordinator = injection.coordinator
    }
    
    // MARK: - Delegate Methods
    
    func tryToLogin(username: String?, password: String?) {
        guard let username, let password else {
            viewController?.incorrectData()
            return
        }
    
        viewController?.startAnimation()

        Task {
            do {
                let response = try await provider.logIn(with: username, password: password)
                saveTokens(response)

                await MainActor.run {
                    viewController?.stopAnimation()
                    coordinator.authSuccessed()
                }
            }
            catch {
                // TODO: - Handle later!
                await MainActor.run {
                    viewController?.incorrectData()
                    viewController?.stopAnimation()
                }
            }
        }
    }
    
    func tryToAuthorize() {
        guard let accessToken: String = KeychainService.getToken(keyType: .refreshToken) else {
            return
        }

        viewController?.startAnimation()

        Task {
            guard let response = try? await provider.tryToAuthorize(with: accessToken).accessToken else { return }
            saveShortToken(response)
            await MainActor.run {
                viewController?.stopAnimation()
                coordinator.authSuccessed()
            }
        }
        
    }
    
    func moveToSignUp() {
        coordinator.moveToCreateAccount()
    }
}

// MARK: - Private Methods

private extension LogInPresenter {
    
    func saveTokens(_ tokens: AuthorizationModel.TokensDto) {
        saveShortToken(tokens.accessToken)
        KeychainService.saveToken(tokens.refreshToken, keyType: .refreshToken)
    }
    
    func saveShortToken(_ token: String) {
        KeychainService.saveToken(token, keyType: .shortToken)
    }
}
