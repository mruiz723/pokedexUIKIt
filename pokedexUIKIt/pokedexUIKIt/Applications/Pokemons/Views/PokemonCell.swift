//
//  PokemonCell.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import UIKit
import Kingfisher

class PokemonCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    @IBOutlet weak var primaryTypeImageView: UIImageView!

    // MARK: - Properties

    private var primaryType: String?
    var gradient: CAGradientLayer?

    var viewModel: PokemonCellViewModelProtocol! {
        didSet {
            viewModel.profile.bindAndFire { [weak self] value in
                guard let url = URL(string: value) else { return }
                self?.profileImageView.kf.setImage(with: url)
            }

            viewModel.name.bindAndFire { [weak self] value in
                self?.nameLabel.text = value
            }

            viewModel.number.bindAndFire { [weak self] value in
                self?.numberLabel.text = value
            }

            viewModel.secondaryType.bindAndFire { [weak self] value in
                guard let name = value else { return }
                self?.secondaryTypeImageView.image = UIImage(named: name)
            }

            viewModel.primaryType.bindAndFire { [weak self] value in
                guard let name = value else { return }
                self?.primaryType = value
                self?.primaryTypeImageView.image = UIImage(named: name)
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
