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

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: update content
    private func setupLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.text = "Unknown"
    }

    // TODO: apply real model
    func applyModel(_ model: String) {
        self.model = model
        label.text = model
        label.sizeToFit()
    }
}
