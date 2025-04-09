//
//  SmokeButtonsTableView.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 27.03.2025.
//

import UIKit

protocol SmokeButtonsDelegate: AnyObject {
    func didTap(at button: SmokeModel.StaticButtons)
}

final class SmokeButtonsTVC: UITableViewCell {
    
    private typealias ButtonModel = SmokeModel.StaticButtons
    
    static let reuseId: String = "SmokeButtonsTVC"
    
    // MARK: - Delegate
    
    weak var delegate: SmokeButtonsDelegate?

    // MARK: - UI
    
    private let smokeButton: CustomButton = .init(settings: .init(style: .filled(color: .csSoftRed, textColor: .csDarkRed), title:  ButtonModel.smoke.title))
    private let stackView: UIStackView = .init(.horizontal)
    private let breathButton: ButtonWithTitleAndSubtitle = .init(viewSettings: .init(title: ButtonModel.breathe.title,
                                                                       subtitle: ButtonModel.breathe.subtitle,
                                                                       titleColor: .csDeepForestGreen,
                                                                       subtitleColor: .csNeutralGreen,
                                                                       backgroundColor: .csPastelGreen))
    private let testLungsButton: ButtonWithTitleAndSubtitle = .init(viewSettings: .init(title: ButtonModel.lungsTest.title,
                                                                          subtitle: ButtonModel.lungsTest.subtitle,
                                                                          titleColor: .csDeepOceanBlue,
                                                                          subtitleColor: .csCalmBlue,
                                                                          backgroundColor: .csSoftSkyBlue))

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension SmokeButtonsTVC {
    
    func setup() {
        addSubviews()
        makeConstraints()
        setupButtons()

        backgroundColor = .clear
        stackView.distribution = .fillEqually
    }
    
    func addSubviews() {
        contentView.addSubview(smokeButton)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(breathButton)
        stackView.addArrangedSubview(testLungsButton)
    }
    
    func makeConstraints() {
        smokeButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(smokeButton.snp.bottom).offset(4)
            $0.bottom.lessThanOrEqualToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func setupButtons() {
        smokeButton.tag = ButtonModel.smoke.rawValue
        breathButton.tag = ButtonModel.breathe.rawValue
        testLungsButton.tag = ButtonModel.lungsTest.rawValue
        
        [smokeButton, breathButton, testLungsButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(_ sender: UIControl) {
        guard let buttonTapped: ButtonModel = .init(rawValue: sender.tag) else { return }
        delegate?.didTap(at: buttonTapped)
    }
}
