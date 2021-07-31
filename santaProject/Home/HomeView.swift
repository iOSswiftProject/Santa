//
//  HomeView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/26.
//

import UIKit

class HomeView: UIView {

    let menuButton = UIButton()
    let tableView = UITableView(frame: .zero, style: .grouped)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupMenuButton()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMenuButton() {
        addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        menuButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 24).isActive = true

        menuButton.setImage(#imageLiteral(resourceName: "santaHomeMenuButton"), for: .normal)
        menuButton.addTarget(self, action: #selector(didTapMenuButton(_:)), for: .touchUpInside)
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

    @objc
    private func didTapMenuButton(_ sender: UIButton) {
        print("home menu button tapped!")
    }
}
