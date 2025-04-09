//
//  BaseViewController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 01.02.2025.
//

import UIKit

protocol BaseViewControllerInterface {
    func startAnimation()
    func stopAnimation()
}

class BaseViewController: UIViewController, BaseViewControllerInterface {
    
    private let loadingAnimation: LoadingAnimationView = .init(frame: .zero)
    
    func startAnimation() {
        view.addSubview(loadingAnimation)
        
        loadingAnimation.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingAnimation.startAnimation()
    }
    
    func stopAnimation() {
        loadingAnimation.stopAnimation()
        loadingAnimation.removeFromSuperview()
    }
}

final class LoadingAnimationView: UIView {
    
    private let loadingAnimation: UIActivityIndicatorView = .init(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        loadingAnimation.startAnimating()
    }
    
    func stopAnimation() {
        loadingAnimation.stopAnimating()
    }
}

private extension LoadingAnimationView {
    
    func setup() {
        addSubviews()
        makeConstraints()
        
        loadingAnimation.color = .csDarkGray
        backgroundColor = .background
    }
    
    func addSubviews() {
        addSubview(loadingAnimation)
    }
    
    func makeConstraints() {
        loadingAnimation.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
