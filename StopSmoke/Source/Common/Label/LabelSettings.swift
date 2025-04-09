//
//  LabelSettings.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 20.03.2025.
//

import UIKit

struct LabelSettings {
    
    let labelType: SmokeFont
    let color: UIColor
    let numberOfLines: Int
    let textAlignment: NSTextAlignment
    
    init(labelType: SmokeFont = .body1, color: UIColor = .csDarkGray, numberOfLines: Int = 0, textAlignment: NSTextAlignment = .natural) {
        self.labelType = labelType
        self.color = color
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
}
