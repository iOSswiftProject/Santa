//
//  HomeViewTableViewCell.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/27.
//

import UIKit

class HomeViewTableViewHeaderView: UITableViewHeaderFooterView {

    static let identifier = "HomeViewTableViewHeaderView"
    static let height: CGFloat = 253

    let climberImageView = UIImageView()
    let backgroundImageView = UIImageView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        setupClimber()
        setupBackgroundView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupClimber() {
        guard let image = UIImage(named: "home_illust_user") else { return }
        contentView.addSubview(climberImageView)
        climberImageView.image = image
        climberImageView.translatesAutoresizingMaskIntoConstraints = false
        climberImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -78).isActive = true
        climberImageView.widthAnchor.constraint(equalToConstant: image.size.width).isActive = true
        climberImageView.heightAnchor.constraint(equalToConstant: image.size.height).isActive = true
        climberImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupBackgroundView() {
        let view = backgroundImageView
        contentView.insertSubview(view, belowSubview: climberImageView)
        view.image = UIImage(named: "home_bg_0")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}

class HomeViewTableViewCell: UITableViewCell {

    static let identifier = "HomeViewTableViewCell"

    private let labelContainerView = UIView()
    let dateLabel = UILabel()
    let nameLabel = UILabel()

    let circle = UIView()
    let line = UIView()

    let mountainImageView = UIImageView()
    let backgroundImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLabels()
        setupLine()
        setupMountainImageView()
        setupBackgroundImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabels() {
        labelContainerView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor).isActive = true

        dateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        dateLabel.textColor = .stGreen40
        dateLabel.textAlignment = .right

        labelContainerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6).isActive = true

        nameLabel.font = .systemFont(ofSize: 12, weight: .init(700))
        nameLabel.textColor = .stGreen40
        nameLabel.textAlignment = .right

        contentView.addSubview(labelContainerView)
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        labelContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        labelContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    private func setupLine() {
        contentView.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.leadingAnchor.constraint(equalTo: labelContainerView.trailingAnchor, constant: 7).isActive = true
        circle.topAnchor.constraint(equalTo: labelContainerView.topAnchor, constant: 2).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 3).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 3).isActive = true

        circle.backgroundColor = .stGreen40
        circle.layer.cornerRadius = 1.5

        contentView.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leadingAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -104).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true

        line.backgroundColor = .stGreen40
    }

    private func setupMountainImageView() {
        contentView.addSubview(mountainImageView)
        mountainImageView.translatesAutoresizingMaskIntoConstraints = false
        mountainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mountainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mountainImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mountainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupBackgroundImageView() {
        backgroundView = backgroundImageView
    }
}
