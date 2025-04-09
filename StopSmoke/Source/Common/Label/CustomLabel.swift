//
//  CustomLabel.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 20.03.2025.
//

import UIKit

final class CustomLabel: UILabel {
    
    // MARK: - Init
    
    required init(settings: LabelSettings) {
        super.init(frame: CGRect.zero)
        self.textColor = settings.color
        self.textAlignment = settings.textAlignment
        self.numberOfLines = settings.numberOfLines
        setupWith(type: settings.labelType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func updateType(_ newType: SmokeFont) {
        setupWith(type: newType)
    }
}

// MARK: - Private Methods

private extension CustomLabel {
    
    func setupWith(type: SmokeFont) {
        self.font = type.get
        alpha = type.alpha
    }
}

extension UILabel {

    private static let swizzleTextSetter: Void = {
        let originalSelector = #selector(setter: UILabel.text)
        let swizzledSelector = #selector(UILabel.localized_setText(_:))

        guard let originalMethod = class_getInstanceMethod(UILabel.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(UILabel.self, swizzledSelector) else {
            return
        }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }()
    
    // MARK: - Свиззленный метод для локализации текста
    
    @objc private func localized_setText(_ text: String?) {
        if let text {
            self.localized_setText(text.localized)
        } else {
            self.localized_setText(nil)
        }
    }

    public static func swizzleUILabel() {
        _ = UILabel.swizzleTextSetter
    }
}

extension String {
    
    var localized: String {
        let localizedString = String.LocalizationValue(self)
        return String(localized: localizedString)
    }
}
