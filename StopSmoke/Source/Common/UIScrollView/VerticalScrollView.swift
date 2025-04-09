//
//  VerticalScrollView.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 28.03.2025.
//

import UIKit

final class VerticalScrollView: UIScrollView {
    
    private var contentView: UIView = .init()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addScrollSubview(_ view: UIView) {
        contentView.addSubview(view)
    }
    
    private func setup() {
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        showsVerticalScrollIndicator = false
    }
}
