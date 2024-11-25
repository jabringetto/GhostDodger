//
//  UpgradesController.swift
//  KillVirus
//
//  Created by Jeremy Bringetto on 11/3/20.
//  Copyright © 2020 Jeremy Bringetto. All rights reserved.
//

import UIKit
import SpriteKit
import StoreKit

protocol UpgradesControllerDelegate: AnyObject {
    func receiveVarsUpdate(newVars: GameSceneVars)
}

final class UpgradesController: UIViewController, UpgradesSceneDelegate {

    weak var delegate: UpgradesControllerDelegate?
    @IBOutlet weak var upgradeView: SKView!
    var scene = UpgradeScene()
    var gameVars: GameSceneVars?
    var upgradeProducts = [SKProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        scene = UpgradeScene.init(size: upgradeView.frame.size)
        scene.upgradeVars.setScreenDimensions(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        // scene.backgroundColor = .init(red:0.65, green:0.32, blue:0.00, alpha:1.0)
        scene.backgroundColor = UIColor.black
        scene.gameVars = gameVars
        scene.varsDelegate = self
        upgradeView.showsFPS = true
        upgradeView.ignoresSiblingOrder = false
        upgradeView.presentScene(scene)
        fetchProducts()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func thankYouForPurchaseAlert(_ upgradeType: UpgradeType, _ paid: Bool) -> UIAlertController {
        var alert = UIAlertController()
        let type = typeStringForType(upgradeType)
        if paid {
            alert = UIAlertController.init(title: "Thank you!", message: "Your have purchased one \(type) for $0.99", preferredStyle: .alert)
        } else {
            alert = UIAlertController.init(title: "Thank you!", message: "Your have purchased one \(type) for 800 points.", preferredStyle: .alert)
        }
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        return alert

    }
    func typeStringForType(_ type: UpgradeType) -> String {
        switch type {
        case .cyclone:
            return "cyclone"
        case .forceField:
            return "force field"
        }
    }
    func showUpgradeAlert(upgradeType: UpgradeType, paid: Bool) {

        let alertTitle = titleForUpgradeType(upgradeType)
        let alertMessage = messageForUpgradeType(upgradeType, isPaid: paid)
        let alert = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        switch upgradeType {
        case .cyclone :

            if paid {
                let paidCycloneAction =  UIAlertAction(title: "Buy", style: .default, handler: { [weak self]  _ in
                    if let product = self?.productFor(upgradeType) {
                        IAPManager.shared.buy(product: product, withHandler: { result in

                            DispatchQueue.main.async {
                                switch result {
                                case .success(_):

                                    self?.scene.addBoughtCyclone()
                                    let alert = self?.thankYouForPurchaseAlert(upgradeType, paid) ?? UIAlertController()
                                    self?.present(alert, animated: false, completion: nil)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }

                        })
                    }
                })
                alert.addAction(paidCycloneAction)

            } else {
                let cycloneAction = UIAlertAction(title: "Buy", style: .default, handler: { [weak self]  _ in
                    self?.scene.buyCyclone()
                    let alert = self?.thankYouForPurchaseAlert(upgradeType, paid) ?? UIAlertController()
                    self?.present(alert, animated: false, completion: nil)

                })
                alert.addAction(cycloneAction)
            }

        case .forceField :

            if paid {
                let paidForceFieldAction =  UIAlertAction(title: "Buy", style: .default, handler: { [weak self]  _ in
                    if let product = self?.productFor(upgradeType) {
                        IAPManager.shared.buy(product: product, withHandler: { result  in

                            DispatchQueue.main.async {
                                switch result {
                                case .success(_):
                                    self?.scene.addBoughtForceField()
                                    let alert = self?.thankYouForPurchaseAlert(upgradeType, paid) ?? UIAlertController()
                                    self?.present(alert, animated: false, completion: nil)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }

                            }

                        })
                    }
                })
                alert.addAction(paidForceFieldAction)

            } else {
                let forceFieldAction = UIAlertAction(title: "Buy", style: .default, handler: { [weak self]  _ in
                    self?.scene.buyForceField()
                    let alert = self?.thankYouForPurchaseAlert(upgradeType, paid) ?? UIAlertController()
                    self?.present(alert, animated: false, completion: nil)
                })
                alert.addAction(forceFieldAction)
            }

        }

        self.present(alert, animated: false, completion: nil)
    }
    func productFor(_ upgradeType: UpgradeType) -> SKProduct {
        let upgradeTypeString = String(describing: upgradeType)
        for product in upgradeProducts {
            if product.productIdentifier.contains(upgradeTypeString) {
                return product
            }
        }
        return SKProduct()
    }
    func titleForUpgradeType(_ upgradeType: UpgradeType) -> String {
        var title = ""
        if upgradeType == .cyclone {
            title += "Cyclone Upgrade"
        } else if upgradeType == .forceField {
            title += "Force Field Upgrade"

        }
        return title
    }
    func messageForUpgradeType(_ upgradeType: UpgradeType, isPaid: Bool) -> String {

        var price: UInt = 0
        let priceMoney = "$0.99"
        var message = "Buy a 30 second "
        if upgradeType == .cyclone {
            message += "cyclone "
            price = GameSceneConstants.cycloneUpgradePrice
        } else if upgradeType == .forceField {
            message += "force field "
            price = GameSceneConstants.forceFieldUpgradePrice

        }
        if isPaid {
            message += "for " + priceMoney + "?"
        } else {
            message += "for \(price) points?"
        }
        return message
    }
    // MARK: - UpgradesSceneDelegate

    func updateVars(newVars: GameSceneVars) {
        self.delegate?.receiveVarsUpdate(newVars: newVars)
    }

    // MARK: - In-App Purchases

    func fetchProducts () {
        IAPManager.shared.getProducts { [weak self] (result) in

            DispatchQueue.main.async {

                switch result {
                case .success(let products):
                    self?.upgradeProducts = products
                    for product in products {
                        print("productIdentifier: \(product.productIdentifier) ")
                        print("price: \(product.price) ")
                    }

                case .failure(let error): print(error)
                }
            }
        }
    }

}
