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

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupClimber()
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
}

class HomeViewTableViewCell: UITableViewCell {

    static let identifier = "HomeViewTableViewCell"

    var mountainImage: UIImage? {
        didSet {
            mountainImageView.image = mountainImage
        }
    }

    let mountainImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupMountainImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMountainImageView() {
        contentView.addSubview(mountainImageView)
        mountainImageView.translatesAutoresizingMaskIntoConstraints = false
        mountainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mountainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mountainImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mountainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
