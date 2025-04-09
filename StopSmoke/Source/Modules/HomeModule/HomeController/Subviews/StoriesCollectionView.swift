//
//  StoriesCollectionView.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

import UIKit

struct StoriesCollectionViewSettings {
    let height: CGFloat
    let width: CGFloat
}

final class StoriesCollectionView: UICollectionView {
    
    // MARK: - Init

    init(viewSettings: StoriesCollectionViewSettings) {
        super.init(frame: .zero, collectionViewLayout: StoriesCollectionView.createLayout(settings: viewSettings))
        register(StoriesCollectionCell.self, forCellWithReuseIdentifier: StoriesCollectionCell.reuseId)
        backgroundColor = .clear
        contentInset = .init(top: .zero, left: 12, bottom: .zero, right: .zero)
        
        snp.makeConstraints {
            $0.height.equalTo(viewSettings.height)
        }
        
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout(settings: StoriesCollectionViewSettings) -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(settings.width), heightDimension: .absolute(settings.height))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(settings.width), heightDimension: .absolute(settings.height))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(6)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 6
            
            return section
        }
    }
}

final class StoriesCollectionCell: UICollectionViewCell {
    
    static let reuseId: String = "StoriesCollectionCell"
    
    // MARK: - UI
    
    private let titleLabel: CustomLabel = .init(settings: .init(labelType: .body3, color: .black, numberOfLines: 0, textAlignment: .left))
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}

// MARK: - Private methods

private extension StoriesCollectionCell {
    
    func setup() {
        addSubviews()
        makeConstraints()
        
        backgroundColor = .red
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(4)
            $0.top.greaterThanOrEqualToSuperview().offset(4)
        }
    }
}
