//
//  LogInViewController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

import UIKit

protocol LogInDisplayLogic: BaseViewController {
    var presenter: LogInPresentationProtocol! {get set}
    
    func incorrectData()
}

final class LogInViewController: BaseViewController {

    // MARK: - MVP Variables
    
    var presenter: LogInPresentationProtocol!
    
    // MARK: - Logic Variables
    
    // MARK: - Data Properties
    
    // MARK: - UI Elements

    private let scrollView: VerticalScrollView = .init()
    private let stackView: UIStackView = .init(.vertical)
    private let loginTextField: PaddedTextField = .init(textFieldType: .email)
    private let passwordTextField: PaddedTextField = .init(textFieldType: .password)
    private let loginButton: CustomButton = .init(settings: .init(style: .bordered, title: "Log In"))
    private let signUpButton: CustomButton = .init(settings: .init(style: .clear(textColor: .csDarkGray), title: "Create account"))

    // MARK: - Init
    
    init(_ injection: LogInModel.Injection) {
        super.init(nibName: nil, bundle: nil)
        configurateModule(injection)
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.tryToAuthorize()
    }
}

// MARK: - Actions

@objc private extension LogInViewController {
    
    func login() {
        presenter.tryToLogin(username: loginTextField.text,
                             password: passwordTextField.text)
    }
    
    func signUpTapped() {
        presenter.moveToSignUp()
    }
}

// MARK: - Private Methods

private extension LogInViewController {
    
    func configurateModule(_ injection: LogInModel.Injection) {
        let assembly: LogInAssembly = .init()
        assembly.configurate(self, injection)
    }
    
    func setup() {
        addSubviews()
        makeConstraints()
        
        view.backgroundColor = .background
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addScrollSubview(stackView)
        
        [loginTextField, passwordTextField, loginButton, signUpButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.bottom.lessThanOrEqualTo(view.keyboardLayoutGuide.snp.top).offset(-18)
        }

        loginTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
}

// MARK: - LogInDisplayLogic

extension LogInViewController: LogInDisplayLogic {

    func incorrectData() {
        loginTextField.shake()
        passwordTextField.shake()
    }
}
