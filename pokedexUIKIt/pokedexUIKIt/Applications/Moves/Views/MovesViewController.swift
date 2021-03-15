//
//  MovesViewController.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import UIKit

class MovesViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var movesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Properties

    var viewModel: MovesViewModelProtocol! {
        didSet {
            loadViewIfNeeded()

            viewModel.moves.bind { [weak self] _ in
                self?.movesTableView.reloadData()
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.moves.value == nil {
            viewModel.viewWillAppear()
        }
    }
}

// MARK: - Private Methods

private extension MovesViewController {

    func setup() {
        movesTableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension MovesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moves.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MoveCell.self), for: indexPath) as? MoveCell else {
            return UITableViewCell()
        }

        cell.viewModel = viewModel.makeViewModelForMoveCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.moves.value?.count ?? 0) - 1 {
            // load more data
            viewModel.willDisplayLastCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension MovesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This delay is only to show a gradient applied when the cell is selected
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            tableView.deselectRow(at: indexPath, animated: false)
            self?.viewModel.didSelectRow(at: indexPath.row)
        }
    }
}

// MARK: - UISearchBarDelegate

extension MovesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMoves(name: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel.filterMoves(name: searchBar.text)
    }
}
