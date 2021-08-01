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
        backgroundColor = .stGreen50
        setupContainer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContainer() {
        let container = UIView()
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        container.addSubview(plusIcon)
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        plusIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 3).isActive = true
        plusIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        plusIcon.widthAnchor.constraint(equalToConstant: Layout.PlusIcon.width).isActive = true
        plusIcon.heightAnchor.constraint(equalToConstant: Layout.PlusIcon.width).isActive = true

        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: plusIcon.trailingAnchor, constant: 11).isActive = true
        label.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

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
        enum PlusIcon {
            static let width: CGFloat = 14
        }

        enum Label {
            static let fontSize: CGFloat = 16
            static let letterSpacing: CGFloat = -0.08
        }
    }
}
