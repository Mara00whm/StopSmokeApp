//
//  CreateAccountViewController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 09.04.2025.
//

import UIKit

protocol CreateAccountDisplayLogic: BaseViewController {
    var presenter: CreateAccountPresentationProtocol! {get set}
    
    func incorrectUserData()
    func accountCreated()
}

final class CreateAccountViewController: BaseViewController {

    // MARK: - MVP Variables
    
    var presenter: CreateAccountPresentationProtocol!
    
    // MARK: - Logic Variables
    
    // MARK: - Data Properties
    
    // MARK: - UI Elements

    private let scrollView: VerticalScrollView = .init()
    private let stackView: UIStackView = .init(.vertical)
    private let loginTextField: PaddedTextField = .init(textFieldType: .email)
    private let passwordTextField: PaddedTextField = .init(textFieldType: .password)
    private let repeatPasswordTextField: PaddedTextField = .init(textFieldType: .repeatedPassword)
    private let signUpButton: CustomButton = .init(settings: .init(style: .bordered, title: "Create account"))

    // MARK: - Init
    
    init(_ injection: CreateAccountModel.Injection) {
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
    }
}

// MARK: - Actions

@objc private extension CreateAccountViewController {
 
    func createAccount() {
        presenter.createAccount(with: .init(userName: loginTextField.text,
                                            password: passwordTextField.text,
                                            repeatedPassword: repeatPasswordTextField.text))
    }
}

// MARK: - Private Methods

private extension CreateAccountViewController {
    
    func configurateModule(_ injection: CreateAccountModel.Injection) {
        let assembly: CreateAccountAssembly = .init()
        assembly.configurate(self, injection)
    }
    
    func setup() {
        addSubviews()
        makeConstraints()
        
        view.backgroundColor = .background
        signUpButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addScrollSubview(stackView)
        
        [loginTextField, passwordTextField, repeatPasswordTextField, signUpButton].forEach {
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

        [loginTextField, passwordTextField, repeatPasswordTextField].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }
    }
}

// MARK: - CreateAccountDisplayLogic

extension CreateAccountViewController: CreateAccountDisplayLogic {
    
    func incorrectUserData() {
        loginTextField.shake()
        passwordTextField.shake()
        repeatPasswordTextField.shake()
    }
    
    func accountCreated() {
        navigationController?.popViewController(animated: true)
    }
}
