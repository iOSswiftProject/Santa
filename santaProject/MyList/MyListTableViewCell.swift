//
//  MyListTableViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/06.
//

import UIKit

class MyListTableViewCell: UITableViewCell {

    static let identifier = "MyListTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
