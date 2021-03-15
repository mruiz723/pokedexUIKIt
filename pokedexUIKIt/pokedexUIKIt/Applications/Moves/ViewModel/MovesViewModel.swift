//
//  MovesViewModel.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation
import MRCommons

class MovesViewModel: MovesViewModelProtocol {

    // MARK: Properties

    let movesManager: MovesManagerProtocol
    var moves: Bindable<[Move]?> = Bindable(nil)
    private var movesCopy: [Move] = []

    // MARK: Events

    var showMoveDetail: ((_ move: Move) -> Void)?
    var shouldShowLoader: ((Bool) -> Void)?
    var showAlert: ((_ message: String) -> Void)?

    // MARK: Initializer

    init(movesManager: MovesManagerProtocol = MovesManager()) {
        self.movesManager = movesManager
    }

    // MARK: Public Methods

    func viewWillAppear() {
        fetchMovesList()
    }

    func fetchMovesList() {
        shouldShowLoader?(true)

        movesManager.fetchMovesList { result in
            DispatchQueue.main.async { [weak self] in
                self?.shouldShowLoader?(false)
                switch result {
                case .success(let moves):
                    self?.moves.value = moves
                case .failure(let error):
                    self?.showAlert?(error.localizedDescription)
                }
            }
        }
    }

    func filterMoves(name: String?) {
        if movesCopy.count == 0 {
            movesCopy = moves.value ?? []
        }

        guard let name = name, name.count > 0 else {
            moves.value = movesCopy
            return
        }

        moves.value = moves.value?.filter { move in
            (move.name.lowercased().contains(name.lowercased()))
        }
    }

    func didSelectRow(at index: Int) {
        guard let move = moves.value?[index] else {
            fatalError("Pokemon is required")
        }

        showMoveDetail?(move)
    }

    func makeViewModelForMoveCell(at indexPath: IndexPath) -> MoveCellViewModel {
        guard let move = moves.value?[indexPath.row] else {
            fatalError("Pokemon is required")
        }

        return MoveCellViewModel(move: move)
    }

    func willDisplayLastCell() {
        // Load more data if list is not filtered
        if MovesManager.movesOffset == moves.value?.count {
            // Load more data
            shouldShowLoader?(true)

            movesManager.fetchMovesList { result in
                DispatchQueue.main.async { [weak self] in
                    self?.shouldShowLoader?(false)
                    switch result {
                    case .success(let moves):
                        self?.moves.value?.append(contentsOf: moves)
                    case .failure(let error):
                        self?.showAlert?(error.localizedDescription)
                    }
                }
            }
        }
    }
}
