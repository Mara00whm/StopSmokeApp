//
//  RelaxViewController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

import UIKit

// TODO: - Do later!

final class BreathingViewController: UIViewController {
    
    let breathingView = BreathingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        breathingView.center = view.center
        view.addSubview(breathingView)
        
        breathingView.isUserInteractionEnabled = true
        breathingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleAnimation)))
    }
    
    @objc func toggleAnimation() {
        breathingView.toggleAnimation()
    }
}

final class BreathingView: UIView {
    
    private let animationDuration: TimeInterval = 12
    private let maxScale: CGFloat = 2.5 // Максимальный размер при расширении
    private var isAnimating = false {
        didSet {
            isAnimating ? stopBreathingAnimation() : startBreathingAnimation()
        }
    }

    private let animationName: String = "relaxing"

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public methods

    func toggleAnimation() {
        isAnimating.toggle()
    }
}

// MARK: - Private methods

private extension BreathingView {

    func startBreathingAnimation() {
        let animation: CABasicAnimation = .init(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = maxScale
        animation.duration = animationDuration / 2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = .init(name: .easeInEaseOut)
        
        layer.add(animation, forKey: animationName)
    }
    
    func stopBreathingAnimation() {
        guard let currentTransform = layer.presentation()?.transform else { return }
        layer.removeAnimation(forKey: animationName)
        layer.transform = currentTransform
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.transform = .identity
        }
    }

    func setupView() {
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
        layer.cornerRadius = frame.width / 2
    }
}
