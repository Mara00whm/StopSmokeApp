//
//  StatisticView.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

import UIKit

enum StatistisViewType {
    case smoked
    case changedMind
    
    var title: String {
        switch self {
        case .smoked:
            return "Cigarettes today"
        case .changedMind:
            return "Changed mind today"
        }
    }
}
final class StatisticView: UIView {
    
    // MARK: - UI

    private let titleLabel: CustomLabel = .init(settings: .init(labelType: .body2, textAlignment: .center))
    private let subtitleLabel: CustomLabel = .init(settings: .init(labelType: .subtitle3, color: .csMediumGray, textAlignment: .center))
    
    // MARK: - Init
    
    init(viewType: StatistisViewType) {
        super.init(frame: .zero)
        setup()
        
        titleLabel.text = viewType.title
        subtitleLabel.text = "0"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
}

private extension StatisticView {
    
    func setup() {
        addSubviews()
        makeConstraints()
        
        addRoundCornersWith(roundMode: .fully)
        backgroundColor = .white
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.horizontalEdges.equalToSuperview().offset(4)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
