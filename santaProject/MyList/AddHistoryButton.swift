//
//  AddHistoryButton.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/10.
//

import UIKit

class AddHistoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: Layout.width).isActive = true
        heightAnchor.constraint(equalToConstant: Layout.height).isActive = true
        backgroundColor = UIColor(hex: "007F36")
        layer.cornerRadius = Layout.cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddHistoryButton {
    private enum Layout {
        static let width: CGFloat = 148
        static let height: CGFloat = 44
        static let cornerRadius: CGFloat = 22
    }
}
