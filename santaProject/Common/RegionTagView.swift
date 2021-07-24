//
//  RegionTagView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/26.
//

import UIKit

class RegionTagView: UIView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = Layout.cornerRadius
        layer.borderWidth = Layout.borderWidth
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: Layout.topMargin).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.topMargin).isActive = true

        label.font = .boldSystemFont(ofSize: Layout.fontSize)
        label.text = "서울"
    }

    func applyRegionName(_ name: String, color: UIColor) {
        label.text = name
        label.textColor = color
        layer.borderColor = color.cgColor
    }
}

extension RegionTagView {
    enum Layout {
        static let sideMargin: CGFloat = 8
        static let topMargin: CGFloat = 6
        static let fontSize: CGFloat = 12
        static let cornerRadius: CGFloat = 12
        static let borderWidth: CGFloat = 1.2
    }
}
