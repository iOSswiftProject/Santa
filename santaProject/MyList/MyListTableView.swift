//
//  MyListTableView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/06.
//

import UIKit

class MyListTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
        showsVerticalScrollIndicator = false
        separatorStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyListTableView {
    enum Layout {
        static let cellPadding: CGFloat = 20
    }
}
