//
//  PokemonCellViewModelProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation
import MRCommons

protocol PokemonCellViewModelProtocol {
    var profile: Bindable<String> { get }
    var name: Bindable<String> { get }
    var number: Bindable<String> { get }
    var secondaryType: Bindable<String?> { get }
    var primaryType: Bindable<String?> { get }
}
