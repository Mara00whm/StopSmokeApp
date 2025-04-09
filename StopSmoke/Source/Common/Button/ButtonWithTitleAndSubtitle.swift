//
//  SquareButton.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 27.03.2025.
//

import UIKit

struct SquareButtonViewSettings {
    let title: String
    var subtitle: String = ""
    
    let titleColor: UIColor
    let subtitleColor: UIColor
    let backgroundColor: UIColor
}

final class ButtonWithTitleAndSubtitle: UIControl {
    
    // MARK: - Init

    private let titleLabel: CustomLabel
    private let subTitleLabel: CustomLabel
    
    // MARK: - Private properties
    
    private let viewSettings: SquareButtonViewSettings

    // MARK: - Init
    
    init(viewSettings: SquareButtonViewSettings) {
        self.viewSettings = viewSettings
        titleLabel =  .init(settings: .init(labelType: .h5, color: viewSettings.titleColor, textAlignment: .center))
        subTitleLabel = .init(settings: .init(color: viewSettings.subtitleColor, textAlignment: .left))
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ButtonWithTitleAndSubtitle {
    
    func setup() {
        addSubviews()
        makeConstraints()
        
        titleLabel.text = viewSettings.title
        backgroundColor = viewSettings.backgroundColor
        addRoundCornersWith(roundMode: .fully, cornersRadius: 12)
        
        subTitleLabel.text = viewSettings.subtitle
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview().inset(6)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.bottom.equalToSuperview().inset(6)
        }
    }
}
