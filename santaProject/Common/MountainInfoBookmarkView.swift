//
//  MountainInfoBookmarkView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/26.
//

import UIKit

class MountainInfoBookmarkView: MountainInfoBaseView {
    private var isBookmark: Bool = false {
        didSet {
            let imageName = isBookmark ? "santaBookmarkActive" : "santaBookmarkInactive"
            let image = UIImage(named: imageName)
            bookMarkButton.setImage(image, for: .normal)
        }
    }

    let bookMarkButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBookmarkButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBookmarkButton() {
        addSubview(bookMarkButton)
        bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookMarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.BookmarkButton.sideMargin).isActive = true
        bookMarkButton.centerYAnchor.constraint(equalTo: subRegionLabel.centerYAnchor).isActive = true
        bookMarkButton.addTarget(self, action: #selector(didTapBookmarkButton(_:)), for: .touchUpInside)
        isBookmark = false
    }
}

extension MountainInfoBookmarkView {
    @objc
    private func didTapBookmarkButton(_ sender: UIButton) {
        isBookmark = !isBookmark
    }
}

extension MountainInfoBookmarkView {
    private enum Layout {
        enum BookmarkButton {
            static let sideMargin: CGFloat = 25
        }
    }
}
