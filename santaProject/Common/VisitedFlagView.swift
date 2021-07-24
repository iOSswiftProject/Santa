//
//  VisitedFlagView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/26.
//

import UIKit

class VisitedFlagView: UIView {

    private let label = UILabel()

    private convenience init(imageName: String, text: String, font: UIFont, textColor: UIColor) {
        self.init(frame: .zero)

        let imageView = UIImageView(image: UIImage(named: imageName))
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Layout.spacing).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        label.font = font
        label.textColor = textColor
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern, value: Layout.letterSpacing, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateText(_ text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern, value: Layout.histroyLetterSpacing, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
    }
}

extension VisitedFlagView {
    enum Layout {
        static let spacing: CGFloat = 2
        static let letterSpacing: CGFloat = -0.08
        static let histroyLetterSpacing: CGFloat = -0.04
        static let fontSize: CGFloat = 12
    }

    public static func unflaggedView() -> VisitedFlagView {
        VisitedFlagView(imageName: "santaFlagInactive",
                        text: "안 다녀온",
                        font: .systemFont(ofSize: Layout.fontSize),
                        textColor: .stCoolGray60)
    }

    public static func flaggedView() -> VisitedFlagView {
        VisitedFlagView(imageName: "santaFlagActive",
                        text: "다녀온 산",
                        font: .boldSystemFont(ofSize: Layout.fontSize),
                        textColor: .stOrange30)
    }
}
