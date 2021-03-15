//
//  PageObject.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 11/03/21.
//

import Foundation

struct PageObject: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [NamedAPIResource]
}
