//
//  UIStackView+Extension.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

import UIKit

extension UIStackView {
    
    convenience init(_ axis: NSLayoutConstraint.Axis, spacing: CGFloat = 8) {
        self.init()
        self.axis = axis
        self.spacing = spacing
    }
}
