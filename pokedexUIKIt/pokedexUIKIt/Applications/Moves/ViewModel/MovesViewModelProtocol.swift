//
//  MovesViewModelProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation
import MRCommons

protocol MovesViewModelProtocol: BaseViewModelProtocol {
    var movesManager: MovesManagerProtocol { get }
    var moves: Bindable<[Move]?> { get set }
    var showMoveDetail: ((_ move: Move) -> Void)? { get set }
    func fetchMovesList()
    func makeViewModelForMoveCell(at indexPath: IndexPath) -> MoveCellViewModel
    func didSelectRow(at index: Int)
    func viewWillAppear()
    func willDisplayLastCell()
    func filterMoves(name: String?)
}
