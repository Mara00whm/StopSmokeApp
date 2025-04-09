//
//  HomeViewController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 21.03.2025.
//

import UIKit

protocol HomeDisplayLogic: UIViewController {
    var presenter: HomePresentationProtocol! {get set}
}

final class HomeViewController: UIViewController {

    // MARK: - MVP Variables
    
    var presenter: HomePresentationProtocol!
    
    // MARK: - UI Elements

    private let scrollView: VerticalScrollView = .init()
    private let stackView: UIStackView = .init(.vertical, spacing: 8)
    private let storiesCollectionView: StoriesCollectionView = .init(viewSettings: .init(height: 130, width: 84))
    private let counterLabel: CustomLabel = .init(settings: .init(labelType: .h4, color: .csDarkGray, numberOfLines: 0, textAlignment: .center))
    private let smokeButton: CustomButton = .init(settings: .init(style: .filled(color: .csSoftRed), title: "smoke"))
    private let cigarettesTodayView: StatisticView = .init(viewType: .smoked)
    private let changedMind: StatisticView = .init(viewType: .changedMind)

    // MARK: - Init
    
    init(_ injection: HomeModel.Injection) {
        super.init(nibName: nil, bundle: nil)
        configurateModule(injection)
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Public Methods

}

// MARK: - Actions

@objc private extension HomeViewController {
    
    func smokeTapped() {
        presenter.smokeTapped()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    
    func configurateModule(_ injection: HomeModel.Injection) {
        let assembly: HomeAssembly = .init()
        assembly.configurate(self, injection)
    }
    
    func setupView() {
        addSubviews()
        makeConstraints()
        setupStoriesCollectionView()

        storiesCollectionView.reloadData()
        
        view.backgroundColor = .background
        smokeButton.addTarget(self, action: #selector (smokeTapped), for: .touchUpInside)
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addScrollSubview(stackView)

        stackView.addArrangedSubview(storiesCollectionView)
        stackView.addArrangedSubview(counterLabel)
        stackView.addArrangedSubview(smokeButton)
        createStatisticsView()
        
        counterLabel.text = "5d 12h 23m"
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview().inset(4)
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
    
    func createStatisticsView() {
        let horizontalStackView: UIStackView = .init(.horizontal)
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.addArrangedSubview(cigarettesTodayView)
        horizontalStackView.addArrangedSubview(changedMind)
        stackView.addArrangedSubview(horizontalStackView)
    }
    
    func setupStoriesCollectionView() {
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
    }
}

// TODO: - Do later

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionCell.reuseId, for: indexPath) as! StoriesCollectionCell
        cell.addRoundCornersWith(roundMode: .fully, cornersRadius: 4)
        return cell
    }
}

// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    
}
