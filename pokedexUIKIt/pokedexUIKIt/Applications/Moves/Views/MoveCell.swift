//
//  MoveCell.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 14/03/21.
//

import UIKit

class MoveCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var primaryTypeImageView: UIImageView!

    // MARK: - Properties

    private var primaryType: String?
    var gradient: CAGradientLayer?

    var viewModel: MoveCellViewModelProtocol! {
        didSet {
            viewModel.primaryType.bindAndFire { [weak self] value in
                guard let name = value else { return }
                self?.primaryType = value
                self?.primaryTypeImageView.image = UIImage(named: name)
            }

            viewModel.name.bindAndFire { [weak self] value in
                self?.nameLabel.text = value
            }
        }
    }

    // MARK: - Public Methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            gradient = PokemonColor.typeLinearGradient(name: primaryType)
            guard let gradient = gradient else { return }
            gradient.frame = bounds
            contentView.layer.insertSublayer(gradient, at: 0)
        } else {
            guard let sublayers = contentView.layer.sublayers, let firstLayer = sublayers.first else { return }
            if firstLayer.isKind(of: CAGradientLayer.self) {
                gradient?.removeFromSuperlayer()
            }
        }
    }
}
