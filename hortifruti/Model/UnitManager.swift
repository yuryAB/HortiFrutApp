//
//  UnitManager.swift
//  hortifruti
//
//  Created by yury antony on 05/06/21.
//

import Foundation
import UIKit

public enum UnitType {
    case fruit
    case green
    case vegetable
}

public class Unit {
    let unitImage: UIImage
    let unitName: String
    let unitType: UnitType
    
    init(image:UIImage,name:String,type:UnitType) {
        unitImage = image
        unitName = name
        unitType = type
    }
}

extension Unit {
    static let allUnits:[Unit] = [ Unit(image: UIImage(named: "couve")!,
                                        name: "Couve", type: .green),
                                   Unit(image: UIImage(named: "repolho")!,
                                        name: "Repolho", type: .green),
                                   Unit(image: UIImage(named: "alface")!,
                                        name: "Alface", type: .green),
                                   Unit(image: UIImage(named: "abobora")!,
                                        name: "Abobora", type: .vegetable),
                                   Unit(image: UIImage(named: "beterraba")!,
                                        name: "Berinjela", type: .vegetable),
                                   Unit(image: UIImage(named: "gangibre")!,
                                        name: "Gengibre", type: .vegetable),
                                   Unit(image: UIImage(named: "laranja")!,
                                        name: "Laranja", type: .fruit),
                                   Unit(image: UIImage(named: "maca")!,
                                        name: "Maca", type: .fruit),
                                   Unit(image: UIImage(named: "maracuja")!,
                                        name: "Maracuja", type: .fruit),
    ]
}


public class UnitManager {
    public func getUnitsBy(_ type: UnitType) -> [Unit] {
        switch type {
        case .fruit:
            return Unit.allUnits.filter{ $0.unitType == .fruit }
        case .vegetable:
            return Unit.allUnits.filter{ $0.unitType == .vegetable }
        case .green:
            return Unit.allUnits.filter{ $0.unitType == .green }
        }
    }
}
