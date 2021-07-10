//
//  AddHistoryButton.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/10.
//

import UIKit

class AddHistoryButton: UIButton {

    private let plusIcon = UIImageView(image: #imageLiteral(resourceName: "santaPlusIcon"))

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: Layout.width).isActive = true
        heightAnchor.constraint(equalToConstant: Layout.height).isActive = true
        backgroundColor = .stGreen50
        layer.cornerRadius = Layout.cornerRadius

        setupPlusIcon()
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPlusIcon() {
        addSubview(plusIcon)
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        plusIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.PlusIcon.leadingMargin).isActive = true
        plusIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        plusIcon.widthAnchor.constraint(equalToConstant: Layout.PlusIcon.width).isActive = true
        plusIcon.heightAnchor.constraint(equalToConstant: Layout.PlusIcon.width).isActive = true
    }

    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.Label.trailingMargin).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        label.font = UIFont.systemFont(ofSize: Layout.Label.fontSize, weight: .init(rawValue: 700))
        label.textColor = .white

        let attributedString = NSMutableAttributedString(string: "다녀온 산 추가")
        attributedString.addAttribute(.kern, value: Layout.Label.letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        label.sizeToFit()
    }
}

extension AddHistoryButton {
    private enum Layout {
        static let width: CGFloat = 148
        static let height: CGFloat = 44
        static let cornerRadius: CGFloat = 22

        enum PlusIcon {
            static let leadingMargin: CGFloat = 19
            static let width: CGFloat = 14
        }

        enum Label {
            static let trailingMargin: CGFloat = 16
            static let fontSize: CGFloat = 16
            static let letterSpacing: CGFloat = -0.08
        }
    }
}
