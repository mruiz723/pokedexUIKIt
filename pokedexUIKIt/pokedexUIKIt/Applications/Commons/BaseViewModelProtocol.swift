//
//  BaseViewModelProtocol.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import Foundation

protocol BaseViewModelProtocol {
    var shouldShowLoader: ((Bool) -> Void)? { get set }
    var showAlert: ((_ message: String) -> Void)? { get set }
}
