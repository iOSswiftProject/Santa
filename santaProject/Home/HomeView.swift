//
//  HomeView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/26.
//

import UIKit

class HomeView: UIView {

    let tableView = UITableView(frame: .zero, style: .grouped)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        tableView.register(HomeViewTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: HomeViewTableViewHeaderView.identifier)
    }
}
