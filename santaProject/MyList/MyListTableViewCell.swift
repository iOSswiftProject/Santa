//
//  MyListTableViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/06.
//

import UIKit

protocol MyListTableViewHistoryCellDelegate: AnyObject {
    func historyCellDidTapMoreButton(_ historyCell: MyListTableViewHistoryCell)
}

protocol MyListTableViewBookmarkCellDelegate: AnyObject {
    func bookmarkCellDidTapMoreButton(_ bookmarkCell: MyListTableViewBookmarkCell)
}

class MyListTableViewHeaderFooterView: UITableViewHeaderFooterView {
    static let identifier = "MyListTableViewHeaderFooterView"
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView?.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyListTableViewHistoryCell: UITableViewCell {
    static let identifier = "MyListTableViewHistoryCell"
    weak var delegate: MyListTableViewHistoryCellDelegate?
    let infoView = MountainInfoHistoryView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layer.cornerRadius = 12
        clipsToBounds = true
        contentView.isUserInteractionEnabled = true
        setupInfoView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInfoView() {
        addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        infoView.delegate = self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        delegate = nil
    }
}

extension MyListTableViewHistoryCell: MountainInfoHistoryViewDelegate {
    func historyViewDidTapMoreButton(_ historyView: MountainInfoHistoryView) {
        delegate?.historyCellDidTapMoreButton(self)
    }
}

class MyListTableViewBookmarkCell: UITableViewCell {
    static let identifier = "MyListTableViewBookmarkCell"
    weak var delegate: MyListTableViewBookmarkCellDelegate?
    let infoView = MountainInfoBookmarkView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layer.cornerRadius = 12
        clipsToBounds = true
        contentView.isUserInteractionEnabled = true
        setupMountainInfoView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMountainInfoView() {
        addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        infoView.delegate = self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension MyListTableViewBookmarkCell: MountainInfoBookmarkViewDelegate {
    func bookmarkViewDidTapBookmarkButton(_ bookmarkView: MountainInfoBookmarkView) {
        delegate?.bookmarkCellDidTapMoreButton(self)
    }
}
