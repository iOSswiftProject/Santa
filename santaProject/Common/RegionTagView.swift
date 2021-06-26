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

        layoutMargins = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        layer.cornerRadius = 12
        layer.borderWidth = 1.2
        layer.borderColor = UIColor(hex: "#85DC40").cgColor
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        addSubview(label)

        label.font = .boldSystemFont(ofSize: 12)
        label.text = "서울"
    }
}
