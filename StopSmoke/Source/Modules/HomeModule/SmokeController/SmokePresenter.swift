//
//  SmokePresenter.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

import UIKit

protocol SmokePresentationProtocol: AnyObject {
    var viewController: SmokeDisplayLogic? {get set}
    
    var sections: [SmokeModel.TableSection] { get }
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func viewModel(for indexPath: IndexPath) -> SmokeModel.CigaretteModel?
    func sectionTitle(for section: Int) -> String?
    func didTap(at button: SmokeModel.StaticButtons)
    
    func loadCigarettes()
}

final class SmokePresenter: SmokePresentationProtocol {
    
    // MARK: - MVP Variables
    
    weak var viewController: SmokeDisplayLogic?
    
    // MARK: - Logic properties
    
    private let formatter: DateFormatter = .init()
    private let calendar = Calendar.current
    private lazy var today = calendar.startOfDay(for: Date())
    private lazy var yesterday = calendar.date(byAdding: .day, value: -1, to: today)

    // MARK: - Managers

    private let coordinator: HomeBaseCoordinator
    private let networkProvider: HomeNetworkProvider

    // MARK: - Data Properties
    
    private var dynamicSections: [SmokeModel.ViewModel] = []
    
    // MARK: - Init
    
    init(_ injection: SmokeModel.Injection) {
        coordinator = injection.coordinator
        networkProvider = injection.networkProvider
    }
    
    // MARK: - Delegate Methods
    
    var sections: [SmokeModel.TableSection] {
        var result: [SmokeModel.TableSection] = [.staticButtons]
        result.append(contentsOf: dynamicSections.map { SmokeModel.TableSection.cigaretteData($0) })
        return result
    }

    var numberOfSections: Int {
        sections.count
    }

    func numberOfRows(in section: Int) -> Int {
        switch sections[section] {
        case .staticButtons:
            1
        case .cigaretteData(let viewModel):
            viewModel.cigarettes.count
        }
    }
    
    func viewModel(for indexPath: IndexPath) -> SmokeModel.CigaretteModel? {
        guard case let .cigaretteData(viewModel) = sections[indexPath.section] else {
            return nil
        }
        return viewModel.cigarettes[indexPath.row]
    }
    
    func sectionTitle(for section: Int) -> String? {
        guard case let .cigaretteData(viewModel) = sections[section] else {
            return nil
        }
        return viewModel.dateDescription
    }
    
    func didTap(at button: SmokeModel.StaticButtons) {
        switch button {
        case .smoke:
            smoke()
        case .breathe:
            coordinator.moveToRelaxVC()
        case .lungsTest:
            break
        }
    }
    
    func loadCigarettes() {
        Task {
            do {
                let cigarettes = try await networkProvider.cigarettes()
                dynamicSections = transformToViewModel(cigarettesDtos: cigarettes.cigarettes)

                await MainActor.run {
                    viewController?.reloadTable()
                }
            }
            catch {
                // TODO: - Handle later
                print(error)
            }
        }
    }
    
    func smoke() {
        Task {
            do {
                let _ = try await networkProvider.smoke()
                loadCigarettes()
            }
            catch {
                print(error)
            }
        }
    }
}

// MARK: - Private Methods

private extension SmokePresenter {
    
    func transformToViewModel(cigarettesDtos: [HomeNetworkModel.CigaretteDto]) -> [SmokeModel.ViewModel] {
        let groupedCigarettes = groupCigarettesByDay(cigarettesDtos: cigarettesDtos)
        return groupedCigarettes.map { (dateDescription, cigarettes) in
            return SmokeModel.ViewModel(dateDescription: dateDescription, cigarettes: cigarettes)
        }
    }
    
    func groupCigarettesByDay(cigarettesDtos: [HomeNetworkModel.CigaretteDto]) -> [(String, [SmokeModel.CigaretteModel])] {
        var grouped = [String: [SmokeModel.CigaretteModel]]()
        for dto in cigarettesDtos {
            let dateDescription = getDateDescription(for: dto.date)
            let cigarette = SmokeModel.CigaretteModel(date: formatDateToSubtitle(dto.date))
            if grouped[dateDescription] != nil {
                grouped[dateDescription]?.append(cigarette)
            } else {
                grouped[dateDescription] = [cigarette]
            }
        }
        return grouped.sorted { $0.key > $1.key }
    }

    func getDateDescription(for date: Date) -> String {
        if calendar.isDate(date, inSameDayAs: today) {
            "Today"
        } else if let yesterdayDate = yesterday,
                  calendar.isDate(date, inSameDayAs: yesterdayDate) {
            "Yesterday"
        } else {
            formatDateToTitle(date)
        }
    }
    
    func formatDateToTitle(_ date: Date) -> String {
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formatDateToSubtitle(_ date: Date) -> String {
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}
