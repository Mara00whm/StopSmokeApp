//
//  UIView+Extension.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

import UIKit

enum ViewRoundMode {
    case top
    case bottom
    case fully
    case noRound
}

extension UIView {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: (center.x - 10), y: center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: (center.x + 10), y: center.y))
        layer.add(shake, forKey: "position")
    }
    
    func addRoundCornersWith(roundMode: ViewRoundMode, cornersRadius: CGFloat = 22) {
        switch roundMode {
        case .top:
            addTopRounding(cornersRadius)
        case .bottom:
            addBottomRounding(cornersRadius)
        case .fully:
            addFullRounding(cornersRadius)
        case .noRound: break
        }
    }
    
    func addDashedBorder(color: CGColor, cornerRadius: CGFloat, lineWidth: CGFloat) {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor, lineWidth: CGFloat) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.lineWidth = lineWidth
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        
        if radius > 0 {
            borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        } else {
            borderLayer.path = UIBezierPath(rect: bounds).cgPath
        }
        
        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    private func addTopRounding(_ cornersRadius: CGFloat) {
        layer.cornerRadius = cornersRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func addBottomRounding(_ cornersRadius: CGFloat) {
        layer.cornerRadius = cornersRadius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func addFullRounding(_ cornersRadius: CGFloat) {
        layer.cornerRadius = cornersRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func addShadow(offset: CGSize = .init(width: 0.0, height: 1.0)) {
        self.layer.shadowColor = UIColor(red: 0.51, green: 0.576, blue: 0.816, alpha: 0.3).cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = 1 // 0.5
        self.layer.shadowRadius = 1.0 // 2.0
    }
}

//MARK: - Content priorities

extension UIView {
    
    func reduceContentCompressionResistancePriority() {
        let priority = self.contentCompressionResistancePriority(for: .horizontal)
        let newPriorityValue = priority.rawValue - 1
        self.setContentCompressionResistancePriority(.init(newPriorityValue), for: .horizontal)
        self.setContentCompressionResistancePriority(.init(newPriorityValue), for: .vertical)
    }
    
    func reduceContentHuggingPriority() {
        let priority = self.contentHuggingPriority(for: .horizontal)
        let newPriorityValue = priority.rawValue - 1
        self.setContentHuggingPriority(.init(newPriorityValue), for: .horizontal)
        self.setContentHuggingPriority(.init(newPriorityValue), for: .vertical)
    }
}
