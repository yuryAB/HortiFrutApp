//
//  HortiUnitsCell.swift
//  hortifruti
//
//  Created by yury antony on 30/05/21.
//

import Foundation
import UIKit

public class HortiUnitsCell: UITableViewCell {
    static let identifier = "hortiUnitsCell"
    
    private lazy var unitName: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var unitImage: UIImageView  = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackView: UIStackView  = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.style()
        self.autolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func style() {
        self.selectionStyle = .none
        stackView.addArrangedSubview(unitImage)
        stackView.addArrangedSubview(unitName)
        self.contentView.backgroundColor = UIColor(named: "unitsBodyBackground")
        self.contentView.addSubview(stackView)
    }
    
    private func autolayout() {
        //Constraints
        stackView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: self.contentView.leadingAnchor,
            multiplier: 1.2
        ).isActive = true
        
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        stackView.setContentCompressionResistancePriority(.defaultHigh,
                                                          for: .horizontal)
        self.contentView.heightAnchor.constraint(equalTo: stackView.heightAnchor,
                                                 multiplier: 1.3).isActive = true
    }
    
    public func fill(unit:Unit){
        unitName.text = unit.unitName
        unitImage.image = unit.unitImage
    }
    
}
