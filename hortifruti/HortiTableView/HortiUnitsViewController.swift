//
//  HortiUnitsViewController.swift
//  hortifruti
//
//  Created by yury antony on 30/05/21.
//

import Foundation
import UIKit

class HortiUnitsViewController: UIViewController {
    private var hortiUnitsView = HortiUnitsView.init()
    public var unitType:UnitType?
    private var units:[Unit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hortiUnitsView.tableView.dataSource = self
        hortiUnitsView.tableView.delegate = self
        self.viewSetup()
        self.navigationControllerSets()
    }
    
    func viewSetup() {
        switch unitType {
        case .fruit:
            self.navigationItem.title = "Frutas"
        case .vegetable:
            self.navigationItem.title = "Legumes"
        case .green:
            self.navigationItem.title = "Verduras"
        case .none:
            print("Setup Error")
        }
        
        self.units = UnitManager().getUnitsBy(unitType!)
        
    }
    
    override func loadView() {
        view = hortiUnitsView
    }
    
    func navigationControllerSets() {
        navigationController?.navigationBar.tintColor = UIColor(named: "unitsBodyBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "unitsTitleBackground")
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension HortiUnitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.units!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HortiUnitsCell.identifier, for: indexPath) as? HortiUnitsCell
        else { return UITableViewCell.init() }
        let unit = self.units![indexPath.row]
        cell.fill(unit: unit)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cameraView = CameraViewController()
        cameraView.searchType = .espec
        cameraView.neededUnit = self.units![indexPath.row]
        self.push(viewController: cameraView, hideBottomBr: false)
    }
}
