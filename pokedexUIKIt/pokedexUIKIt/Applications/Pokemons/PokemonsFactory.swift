//
//  PokemonsFactory.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation

struct PokemonsFactory {

    static func makeViewController() -> PokemonsViewController {
        let viewModel = PokemonsViewModel()
        let viewController = PokemonsViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}
