//
//  MyListCollectionViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/13.
//

import UIKit

protocol MyListCollectionViewCellDelegate: AnyObject {
    func didTapAddHistoryButton()
}

class MyListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyListCollectionViewCell"

    weak var delegate: MyListCollectionViewCellDelegate?

    private var viewModel: MyListTableViewModel?

    let tableView = UITableView(frame: .zero, style: .plain)

    let addHistoryButton = AddHistoryButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupTableView()
        setupAddHistoryButton()
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

        tableView.register(MyListTableViewHistoryCell.self, forCellReuseIdentifier: MyListTableViewHistoryCell.identifier)
        tableView.register(MyListTableViewBookmarkCell.self, forCellReuseIdentifier: MyListTableViewBookmarkCell.identifier)
        tableView.register(MyListTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: MyListTableViewHeaderFooterView.identifier)

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupAddHistoryButton() {
        addSubview(addHistoryButton)
        addHistoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        addHistoryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18).isActive = true
        addHistoryButton.addTarget(self, action: #selector(didTapAddHistoryButton(_:)), for: .touchUpInside)
        addHistoryButton.isHidden = true
    }

    func applyViewModel(_ model: MyListTableViewModel) {
        self.viewModel = model
        switch viewModel {
        case is MyListHistoryTableViewModel:
            addHistoryButton.isHidden = false
        default:
            addHistoryButton.isHidden = true
        }
        tableView.reloadData()
    }

    @objc
    private func didTapAddHistoryButton(_ sender: UIButton) {
        delegate?.didTapAddHistoryButton()
    }
}

extension MyListCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel {
        case is MyListHistoryTableViewModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewHistoryCell.identifier),
                  let listCell = cell as? MyListTableViewHistoryCell,
                  let cellModel = viewModel?.cellModel(for: indexPath) as? MyListTableViewHistoryCellModel else { return UITableViewCell() }
            cellModel.configure(listCell)
            return listCell
        case is MyListFavoriteTableViewModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewBookmarkCell.identifier),
                  let listCell = cell as? MyListTableViewBookmarkCell,
                  let cellModel = viewModel?.cellModel(for: indexPath) as? MyListTableViewBookmarkCellModel else { return UITableViewCell() }
            cellModel.configure(listCell)
            return listCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Layout.cellHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Layout.cellSpacing
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
