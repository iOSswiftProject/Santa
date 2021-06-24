//
//  MyListCollectionViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/13.
//

import UIKit

class MyListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyListCollectionViewCell"

    private var model: String = ""

    private let tableView = UITableView(frame: .zero, style: .plain)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideMargin).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false

        tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.identifier)
        tableView.register(MyListTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: MyListTableViewHeaderFooterView.identifier)

        tableView.dataSource = self
        tableView.delegate = self
    }

    // TODO: apply real model
    func applyModel(_ model: String) {
        self.model = model
        tableView.reloadData()
    }
}

extension MyListCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier),
              let listCell = cell as? MyListTableViewCell else { return UITableViewCell() }
        switch model {
        case "History":
            listCell.showTimestampLabel()
        case "Favorite":
            listCell.showBookmarkButton()
        default:
            fatalError("not implemented")
        }
        
        return listCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Layout.cellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        return Layout.topSpacing
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Layout.cellSpacing
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: MyListTableViewHeaderFooterView.identifier)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: MyListTableViewHeaderFooterView.identifier)
    }
}

extension MyListCollectionViewCell: UITableViewDelegate {
    private enum Layout {
        static let sideMargin: CGFloat = 20
        static let topSpacing: CGFloat = 16
        static let cellSpacing: CGFloat = 12
        static let cellHeight: CGFloat = 96
    }
}
