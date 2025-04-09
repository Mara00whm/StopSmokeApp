//
//  SmokeViewController.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

import UIKit

protocol SmokeDisplayLogic: UIViewController {
    var presenter: SmokePresentationProtocol! {get set}
    
    func reloadTable()
}

final class SmokeViewController: UIViewController {

    // MARK: - MVP Variables
    
    var presenter: SmokePresentationProtocol!
    
    // MARK: - UI Elements

    private let tableView: UITableView = .init(frame: .zero, style: .grouped)

    // MARK: - Init
    
    init(_ injection: SmokeModel.Injection) {
        super.init(nibName: nil, bundle: nil)
        configurateModule(injection)
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.loadCigarettes()
    }
}

// MARK: - Private Methods

private extension SmokeViewController {
    
    func configurateModule(_ injection: SmokeModel.Injection) {
        let assembly: SmokeAssembly = .init()
        assembly.configurate(self, injection)
    }
    
    func setup() {
        addSubviews()
        makeConstraints()
        setupTableView()

        view.backgroundColor = .background
        navigationItem.title = "Smoke"
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SmokeButtonsTVC.self, forCellReuseIdentifier: SmokeButtonsTVC.reuseId)
        tableView.register(SmokeDateTVC.self, forCellReuseIdentifier: SmokeDateTVC.reuseId)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .background
        tableView.reloadData()
    }

    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SmokeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.sections[indexPath.section] {
        case .staticButtons:
            let cell = tableView.dequeueReusableCell(withIdentifier: SmokeButtonsTVC.reuseId, for: indexPath) as! SmokeButtonsTVC
            cell.delegate = self
            return cell
            
        case .cigaretteData:
            let cell = tableView.dequeueReusableCell(withIdentifier: SmokeDateTVC.reuseId, for: indexPath) as! SmokeDateTVC
            if let model = presenter.viewModel(for: indexPath) {
                cell.configure(with: model.date)
            }
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dateDescription: String = presenter.sectionTitle(for: section) else { return nil }

        let view: CustomLabel = .init(settings: .init(labelType: .h4))
        view.text = dateDescription
        return view
    }
}

// MARK: - SmokeDisplayLogic

extension SmokeViewController: SmokeDisplayLogic {
    
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - SmokeButtonsDelegate

extension SmokeViewController: SmokeButtonsDelegate {

    func didTap(at button: SmokeModel.StaticButtons) {
        presenter.didTap(at: button)
    }
}
