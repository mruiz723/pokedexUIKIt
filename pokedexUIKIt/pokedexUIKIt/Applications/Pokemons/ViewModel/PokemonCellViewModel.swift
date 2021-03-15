//
//  PokemonCellViewModel.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation
import MRCommons

struct PokemonCellViewModel: PokemonCellViewModelProtocol {
    let profile: Bindable<String>
    let name: Bindable<String>
    let number: Bindable<String>
    let secondaryType: Bindable<String?>
    let primaryType: Bindable<String?>

    init(pokemon: Pokemon) {
        self.profile = Bindable(pokemon.sprites.other.officialArtwork.frontDefault)
        self.name = Bindable(pokemon.name.capitalized)
        self.number = Bindable(pokemon.formattedNumber())
        self.secondaryType = Bindable(pokemon.secondaryType())
        self.primaryType = Bindable(pokemon.primaryType())
    }
}
