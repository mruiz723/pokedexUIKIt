//
//  MovesFactory.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation

struct MovesFactory {

    static func makeViewController() -> MovesViewController {
        let viewModel = MovesViewModel()
        let viewController = MovesViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}
