//
//  Font.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 20.03.2025.
//

import UIKit

enum SmokeFont {
    
    /// size = 96;
    /// weight = 300;
    case h1
    
    /// size = 60;
    /// weight = 300;
    case h2
    
    /// size = 48;
    /// weight = 400;
    case h3
    
    /// size = 34;
    /// weight = 400;
    case h4
    
    /// size = 24;
    /// weight = 400;
    case h5
    
    /// size = 20;
    /// weight = 500;
    case h6
    
    /// size = 18;
    /// weight = 400;
    case subtitle1
    
    /// size = 16;
    /// weight = 500;
    case subtitle2
    
    /// size = 14;
    /// weight = 400;
    case subtitle3
    
    /// size = 18;
    /// weight = 300;
    case body1
    
    /// size = 16;
    /// weight = 400;
    case body2
    
    /// size = 14;
    /// weight = 400;
    case body3
    
    /// size = 14;
    /// weight = 500;
    case button
    
    /// size = 12;
    /// weight = 400;
    case caption
    
    /// size = 12;
    /// weight = 400;
    case overline
    
    case custom(size: Int, weight: Int)
    
    var weight: UIFont.Weight {
        switch self {
        case .h1, .h2, .body1:
            .init(CGFloat(SmokeFontWeight.light.rawValue))
        case .h3, .h4, .h5, .subtitle1, .subtitle3, .caption, .overline, .body2, .body3:
            .init(CGFloat(SmokeFontWeight.regular.rawValue))
        case .h6, .subtitle2, .button:
            .init(CGFloat(SmokeFontWeight.medium.rawValue))
        case .custom(_, weight: let weight):
            .init(CGFloat(weight))
        }
    }
    
    var size: CGFloat {
        switch self {
        case .h1:
            96
        case .h2:
            60
        case .h3:
            48
        case .h4:
            34
        case .h5:
            24
        case .h6:
            20
        case .subtitle1, .body1:
            18
        case .subtitle2, .body2:
            16
        case .subtitle3, .body3, .button:
            14
        case .caption, .overline:
            12
        case .custom(let size, _):
            CGFloat(size)
        }
    }
    
    var alpha: CGFloat {
        1
    }
    
    var get: UIFont {
        guard let siriusFontWeight = SmokeFontWeight(rawValue: Int(weight.rawValue)) else { return getCustomFontWithName(FontName.regular.rawValue, andSize: size) }
        return switch siriusFontWeight {
        case .light:
            getCustomFontWithName(FontName.light.rawValue, andSize: size)
        case .regular:
            getCustomFontWithName(FontName.regular.rawValue, andSize: size)
        case .medium:
            getCustomFontWithName(FontName.medium.rawValue, andSize: size)
        }
    }
    
    private func getCustomFontWithName(_ name: String, andSize size: CGFloat) -> UIFont {
        .init(name: name, size: size) ?? .systemFont(ofSize: size)
    }
    
    private enum FontName: String {
        case light = "Rubik-Light"
        case regular = "Rubik-Regular"
        case medium = "Rubik-Medium"
    }
}

private enum SmokeFontWeight: Int {
    case light = 300
    case regular = 400
    case medium = 500
}
