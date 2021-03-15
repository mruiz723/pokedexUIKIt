//
//  BaseViewController.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 12/03/21.
//

import UIKit
import MRCommons
import SVProgressHUD

class BaseViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension BaseViewController: AlertProtocol {

    func showAlert(msg: String, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: Constants.AlertTitle.pokemon, message: msg, preferredStyle: UIAlertController.Style.alert)

        if let actions = actions {
            actions.forEach { alert.addAction($0) }
        } else {
            alert.addAction(UIAlertAction(title: Constants.ActionTitle.ok, style: UIAlertAction.Style.default, handler: nil))
        }

        present(alert, animated: true, completion: nil)
    }

    func shouldShowLoader(_ shouldShow: Bool) {
        shouldShow ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
}
