//
//  Move.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation

struct Move: Codable {
    let id: Int
    let accuracy: Int?
    let name: String
    let type: NamedAPIResource

    // There are more properties...
}

extension Move {
    func primaryType() -> String {
        return type.name.capitalized
    }
}
