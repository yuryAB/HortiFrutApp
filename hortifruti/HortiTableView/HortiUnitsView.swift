//
//  HortiUnitsView.swift
//  hortifruti
//
//  Created by yury antony on 30/05/21.
//

import Foundation
import UIKit

//--Mark InterfaceComponents
class HortiUnitsView: UIView {
    private(set) var tableView = UITableView.init()
    
    init() {
        super.init(frame: .zero)
        self.style()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func style() {
        tableView.register(HortiUnitsCell.self, forCellReuseIdentifier: HortiUnitsCell.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor(named: "unitsBodyBackground")
        self.addSubview(tableView)
    }
    
    public func autoLayout() {
        //Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
