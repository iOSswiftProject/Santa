//
//  regionTableCell.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/16.
//

import UIKit

class RegionTableHeaderFooterView: UITableViewHeaderFooterView {
    static let identifier = "RegionTableHeaderFooterView"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = .stCoolGray25
    }
}

class regionTableCell: UITableViewCell {
    var idx: Int?
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 200, height: 30))
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0
        return view
    }()
    
    lazy var regionLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 10, y: 15, width: 50, height: 15))
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var mountainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.setColor(_names: .lightlightgray)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    //TODO: 상세사이즈 수정
    lazy var nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(UIImage(named: "santaIconArrow"), for: .normal)
       return button
    }()
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(corder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(view)
        self.view.addSubview(regionLabel)
        self.view.addSubview(mountainLabel)
        self.view.addSubview(nextButton)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        regionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        regionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.isUserInteractionEnabled = false
        nextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        mountainLabel.translatesAutoresizingMaskIntoConstraints = false
        mountainLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        mountainLabel.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -8).isActive = true

    }
    
}
