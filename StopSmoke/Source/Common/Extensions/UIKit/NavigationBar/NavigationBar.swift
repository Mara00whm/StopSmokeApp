//
//  NavigationBar.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

extension UINavigationBar {
    
    func clearBackButtonText() {
        topItem?.backButtonDisplayMode = .minimal
    }
    
    func setupStyle(backroundColor: UIColor? = .background, tintColor: UIColor? = .black, font: UIFont? = SmokeFont.body2.get) {
        let backroundColor = backroundColor
        let tintColor = tintColor ?? UIColor.white
        let font = font
        let titleAttributes = [NSAttributedString.Key.foregroundColor: tintColor, NSAttributedString.Key.font: font]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = backroundColor
        appearance.titleTextAttributes = titleAttributes
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        
        isTranslucent = false
        self.tintColor = tintColor
    }

    func hideShadowLine() {
        standardAppearance.shadowColor = .clear
        scrollEdgeAppearance?.shadowColor = .clear
    }

    func showShadowLine() {
        standardAppearance.shadowColor = .gray
        scrollEdgeAppearance?.shadowColor = .gray
    }
}
