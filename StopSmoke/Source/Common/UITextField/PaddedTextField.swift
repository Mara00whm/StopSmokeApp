//
//  PaddedTextField.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

import UIKit

enum PaddedTextFieldType {
    case email
    case password
    case repeatedPassword
    case custom(placeholder: String)
    
    var placeholder: String {
        switch self {
        case .email:
            return "Enter your login"
        case .password:
            return "Enter your password"
        case .repeatedPassword:
            return "Repeat password"
        case .custom(placeholder: let placeholder):
            return placeholder
        }
    }
}

final class PaddedTextField: UITextField {

    private let padding: UIEdgeInsets

    // MARK: - Init

    init(padding: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10), textFieldType: PaddedTextFieldType) {
        self.padding = padding

        super.init(frame: .zero)

        setup(textFieldType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Private methods
    
    private func setup(_ textFieldType: PaddedTextFieldType) {
        font = SmokeFont.body2.get
        autocapitalizationType = .none
        layer.borderWidth = 1
        layer.borderColor = UIColor.csDarkGray.cgColor
        autocorrectionType = .no
        spellCheckingType = .no
        smartQuotesType = .no
        smartDashesType = .no
        smartInsertDeleteType = .no
        placeholder = textFieldType.placeholder

        addRoundCornersWith(roundMode: .fully, cornersRadius: 12)
        
        
        switch textFieldType {
        case .email:
            keyboardType = .emailAddress
        case .password, .repeatedPassword:
            isSecureTextEntry = true
        default:
            keyboardType = .default
        }
    }
}
