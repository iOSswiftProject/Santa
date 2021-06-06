//
//  MyListTableViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/06.
//

import UIKit

class MyListTableViewCell: UITableViewCell {

    static let identifier = "MyListTableViewCell"

    let nameLabel = UILabel()

    let locationLabel = UILabel()

    let separator = UIView()

    let heightLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layer.cornerRadius = Layout.cornerRadius
        clipsToBounds = true

        setupNameLabel()
        setupLocationLabel()
        setupSeparator()
        setupHeightLabel()
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
}

extension MyListTableViewCell {
    public enum Layout {
        static var cellHeight: CGFloat = 88
        static let cornerRadius: CGFloat = 12
    }
}
