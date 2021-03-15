//
//  PokemonsViewController.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import UIKit
import MRCommons

class PokemonsViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var pokemonsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Properties

    var viewModel: PokemonsViewModelProtocol! {
        didSet {
            loadViewIfNeeded()

            viewModel.pokemons.bind { [weak self] _ in
                self?.pokemonsTableView.reloadData()
            }

            viewModel.shouldShowLoader = { [weak self] shouldShow in
                self?.shouldShowLoader(shouldShow)
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.viewDidLoad()
    }
}

// MARK: - Private Methods

private extension PokemonsViewController {

    func setup() {
        title = Constants.Title.pokemons
        pokemonsTableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension PokemonsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonCell.self), for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }

        cell.viewModel = viewModel.makeViewModelForPokemonCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.pokemons.value?.count ?? 0) - 1 {
            // load more data
            viewModel.willDisplayLastCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension PokemonsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This delay is only to show a gradient applied when the cell is selected
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            tableView.deselectRow(at: indexPath, animated: false)
            self?.viewModel.didSelectRow(at: indexPath.row)
        }
    }
}

// MARK: - UISearchBarDelegate

extension PokemonsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPokemons(name: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel.filterPokemons(name: searchBar.text)
    }
}
