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

        backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        layer.cornerRadius = Layout.cornerRadius
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyListTableViewCell {
    public enum Layout {
        static var cellHeight: CGFloat = 88
        static let cornerRadius: CGFloat = 12
    }
}
