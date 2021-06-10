//
//  ViewController.swift
//  hortifruti
//
//  Created by yury antony on 23/05/21.
//

import UIKit

//--Mark InterfaceComponents
class ViewController: UIViewController {
    @IBOutlet weak var geralButton: UIButton!
    @IBOutlet weak var verdurasButton: UIButton!
    @IBOutlet weak var legumesButton: UIButton!
    @IBOutlet weak var frutasButton: UIButton!
    let unitMnager = UnitManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func geralButtonAction(_ sender: Any) {
        let newViewController = CameraViewController()
        newViewController.modalPresentationStyle = .fullScreen
        self.push(viewController: newViewController, hideBottomBr: false)
    }
    
    @IBAction func verdurasButtonAction(_ sender: Any) {
        let newViewController = HortiUnitsViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.unitType = UnitType.green
        self.navigationController!.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func legumesButtonAction(_ sender: Any) {
        let newViewController = HortiUnitsViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.unitType = UnitType.vegetable
        self.navigationController!.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func frutasButtonAction(_ sender: Any) {
        let newViewController = HortiUnitsViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.unitType = UnitType.fruit
        self.navigationController!.pushViewController(newViewController, animated: true)
    }
}

extension UIViewController {
    func push(viewController: UIViewController, hideBottomBr: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
