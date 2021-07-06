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

    private var flagged: Bool = false {
        didSet {
            unflaggedView.isHidden = flagged
            flaggedView.isHidden = !flagged
        }
    }

    let bookMarkButton = UIButton()
    let unflaggedView = VisitedFlagView.unflaggedView()
    let flaggedView = VisitedFlagView.flaggedView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBookmarkButton()
        setupUnflaggedView()
        setupFlaggedView()
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

    private func setupUnflaggedView() {
        addSubview(unflaggedView)
        unflaggedView.translatesAutoresizingMaskIntoConstraints = false
        unflaggedView.trailingAnchor.constraint(equalTo: bookMarkButton.leadingAnchor, constant: -Layout.Flagged.spacing).isActive = true
        unflaggedView.centerYAnchor.constraint(equalTo: bookMarkButton.centerYAnchor).isActive = true

        // TODO: hide on init
//        unflaggedView.isHidden = true
    }

    private func setupFlaggedView() {
        addSubview(flaggedView)
        flaggedView.translatesAutoresizingMaskIntoConstraints = false
        flaggedView.trailingAnchor.constraint(equalTo: bookMarkButton.leadingAnchor, constant: -Layout.Flagged.spacing).isActive = true
        flaggedView.centerYAnchor.constraint(equalTo: bookMarkButton.centerYAnchor).isActive = true
        flaggedView.isHidden = true
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
            static let sideMargin: CGFloat = 20
        }
        enum Flagged {
            static let spacing: CGFloat = 16
        }
    }
}
