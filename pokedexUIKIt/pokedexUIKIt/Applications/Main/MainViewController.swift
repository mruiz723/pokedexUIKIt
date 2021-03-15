//
//  MainViewController.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray

        let pokemonsItem = UITabBarItem()
        pokemonsItem.title = "Pokemons"
        pokemonsItem.image = UIImage(named: "pokemon")
        pokemonsItem.selectedImage = UIImage(named: "pokemonActive")

        let pokemonVC = PokemonsFactory.makeViewController()
        pokemonVC.tabBarItem = pokemonsItem

        let movesItem = UITabBarItem()
        movesItem.title = "Moves"
        movesItem.image = UIImage(named: "moves")
        movesItem.selectedImage = UIImage(named: "movesActive")

        let movesVC = MovesFactory.makeViewController()
        movesVC.tabBarItem = movesItem

        self.viewControllers = [pokemonVC, movesVC]
    }

}
