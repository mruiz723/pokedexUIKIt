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
        let item = UITabBarItem()
        item.title = "Pokemons"
        item.image = UIImage(named: "pokemon")
        item.selectedImage = UIImage(named: "pokemonActive")

        let pokemonVC = PokemonsFactory.makeViewController()
        pokemonVC.tabBarItem = item

        self.viewControllers = [pokemonVC]
    }

}
