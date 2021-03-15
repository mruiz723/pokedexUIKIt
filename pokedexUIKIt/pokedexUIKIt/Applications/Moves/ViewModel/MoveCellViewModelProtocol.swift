//
//  MoveCellViewModelProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import Foundation
import MRCommons

protocol MoveCellViewModelProtocol {
    var name: Bindable<String> { get }
    var primaryType: Bindable<String?> { get }
}
