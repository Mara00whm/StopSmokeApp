//
//  SmokeDateTVC.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 06.04.2025.
//

import UIKit

final class SmokeDateTVC: UITableViewCell {
    
    static let reuseId: String = "SmokeDateTVC"
    
    // MARK: - UI
    
    private let titleLabel: CustomLabel = .init(settings: .init(labelType: .body2, textAlignment: .left))
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Private methods

private extension SmokeDateTVC {
    
    func setup() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
}
