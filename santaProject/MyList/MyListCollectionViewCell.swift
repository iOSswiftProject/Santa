//
//  MyListCollectionViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/13.
//

import UIKit

protocol MyListCollectionViewCellDelegate: AnyObject {
    func didTapAddHistoryButton()
    func didTapMoreButtonForHistoryIndexPath(_ indexPath: IndexPath)
}

class MyListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyListCollectionViewCell"

    weak var delegate: MyListCollectionViewCellDelegate?

    private var viewModel: MyListTableViewModel?

    let tableView = UITableView(frame: .zero, style: .plain)

    let addHistoryButton = AddHistoryButton()

    let historyEmptyView = UIView()

    let favoriteEmptyView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupTableView()
        setupAddHistoryButton()
        setupHistoryEmptyView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHistoryEmptyView() {
        let view = historyEmptyView

        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        let imageView = UIImageView(image: UIImage(named: "history_empty"))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit

        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)

        let attrString = NSMutableAttributedString(string: "다녀온 산이 없습니다.\n다녀온 산을 추가해 보세요.")
        let range = NSRange(location: 0, length: attrString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        paragraphStyle.alignment = .center
        attrString.addAttribute(.kern, value: -0.08, range: range)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        label.attributedText = attrString

        let button = AddHistoryButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 56).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 220).isActive = true
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(didTapAddHistoryButton(_:)), for: .touchUpInside)

        historyEmptyView.isHidden = true
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
        tableView.separatorStyle = .none

        tableView.register(MyListTableViewHistoryCell.self, forCellReuseIdentifier: MyListTableViewHistoryCell.identifier)
        tableView.register(MyListTableViewBookmarkCell.self, forCellReuseIdentifier: MyListTableViewBookmarkCell.identifier)
        tableView.register(MyListTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: MyListTableViewHeaderFooterView.identifier)

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupAddHistoryButton() {
        addSubview(addHistoryButton)
        translatesAutoresizingMaskIntoConstraints = false
        addHistoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        addHistoryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18).isActive = true
        addHistoryButton.widthAnchor.constraint(equalToConstant: 148).isActive = true
        addHistoryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addHistoryButton.layer.cornerRadius = 22
        addHistoryButton.addTarget(self, action: #selector(didTapAddHistoryButton(_:)), for: .touchUpInside)
        addHistoryButton.isHidden = true
    }

    func removeHistory(at index: Int) {
        guard viewModel is MyListHistoryTableViewModel else { return }
        tableView.beginUpdates()
        tableView.deleteSections([index], with: .automatic)
        tableView.endUpdates()

        guard viewModel?.count == 0 else { return }
        historyEmptyView.isHidden = false
        addHistoryButton.isHidden = true
    }

    func applyViewModel(_ model: MyListTableViewModel) {
        self.viewModel = model
        let isEmpty = model.count == 0
        switch viewModel {
        case is MyListHistoryTableViewModel:
            favoriteEmptyView.isHidden = true
            historyEmptyView.isHidden = !isEmpty
            addHistoryButton.isHidden = isEmpty
        default:
            historyEmptyView.isHidden = true
            addHistoryButton.isHidden = true
            favoriteEmptyView.isHidden = !isEmpty
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
            listCell.delegate = self
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

extension MyListCollectionViewCell: MyListTableViewHistoryCellDelegate {
    func historyCellDidTapMoreButton(_ historyCell: MyListTableViewHistoryCell) {
        guard viewModel is MyListHistoryTableViewModel,
              let indexPath = tableView.indexPath(for: historyCell)
        else { return }
        delegate?.didTapMoreButtonForHistoryIndexPath(indexPath)
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
