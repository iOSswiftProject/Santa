//
//  MyListTableViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/06.
//

import UIKit

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

class MyListTableViewCell: UITableViewCell {

    static let identifier = "MyListTableViewCell"

    let nameLabel = UILabel()

    let locationLabel = UILabel()

    let separator = UIView()

    let heightLabel = UILabel()

    let timestampLabel = UILabel()

    let bookmarkButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layer.cornerRadius = Layout.cornerRadius
        clipsToBounds = true
        contentView.isUserInteractionEnabled = true

        setupNameLabel()
        setupLocationLabel()
        setupSeparator()
        setupHeightLabel()
        setupTimestampLabel()
        setupBookmarkButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNameLabel() {
        addSubview(nameLabel)

        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.text = "관악산"

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        nameLabel.sizeToFit()
    }

    private func setupLocationLabel() {
        addSubview(locationLabel)

        locationLabel.font = .systemFont(ofSize: 12)
        locationLabel.textColor = UIColor(hex: "BBBBBB")
        locationLabel.text = "서울시 관악구"

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        locationLabel.sizeToFit()
    }

    private func setupSeparator() {
        addSubview(separator)

        separator.backgroundColor = UIColor(hex: "EFEFEF")

        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 8).isActive = true
        separator.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }

    private func setupHeightLabel() {
        addSubview(heightLabel)

        heightLabel.font = .systemFont(ofSize: 12)
        heightLabel.textColor = UIColor(hex: "BBBBBB")
        heightLabel.text = "632m"

        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 8).isActive = true
        heightLabel.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        heightLabel.sizeToFit()
    }

    private func setupTimestampLabel() {
        addSubview(timestampLabel)

        timestampLabel.font = .systemFont(ofSize: 12)
        timestampLabel.textColor = .white
        timestampLabel.textAlignment = .center
        timestampLabel.text = "2021.05.03"

        timestampLabel.backgroundColor = UIColor(hex: "FF8E8E")
        timestampLabel.layer.cornerRadius = 12
        timestampLabel.clipsToBounds = true

        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        timestampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        timestampLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        timestampLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
        timestampLabel.isHidden = true
    }

    private func setupBookmarkButton() {
        addSubview(bookmarkButton)

        bookmarkButton.backgroundColor = UIColor(hex: "FF8C8C")

        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        bookmarkButton.widthAnchor.constraint(equalToConstant: 14).isActive = true
        bookmarkButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bookmarkButton.isHidden = true

        bookmarkButton.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
    }

    @objc
    private func didTapBookmarkButton() {
        print("bookmark button tapped. TODO: remove from bookmark list")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        timestampLabel.isHidden = true
        bookmarkButton.isHidden = true
    }

    public func showTimestampLabel() {
        timestampLabel.isHidden = false
    }

    public func showBookmarkButton() {
        bookmarkButton.isHidden = false
    }
}

extension MyListTableViewCell {
    public enum Layout {
        static let cornerRadius: CGFloat = 12
    }
}
