//
//  MoveCellViewModel.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation
import MRCommons

struct MoveCellViewModel: MoveCellViewModelProtocol {
    let name: Bindable<String>
    let primaryType: Bindable<String?>

    init(move: Move) {
        self.name = Bindable(move.name.capitalized)
        self.primaryType = Bindable(move.primaryType())
    }
}
