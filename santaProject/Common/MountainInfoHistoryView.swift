//
//  MountainInfoHistoryView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/26.
//

import UIKit

class MountainInfoHistoryView: MountainInfoBaseView {

    private let moreButton = UIButton()
    private let timestampView = VisitedFlagView.flaggedView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMoreButton()
        setupTimestampView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMoreButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: mountainNameView.centerYAnchor).isActive = true

        let buttonImage = UIImage(named: "santaMoreButton")?.withRenderingMode(.alwaysTemplate)
        moreButton.setImage(buttonImage, for: .normal)
        moreButton.tintColor = .stCoolGray50
        moreButton.addTarget(self, action: #selector(didTapMoreButton(_:)), for: .touchUpInside)
    }

    private func setupTimestampView() {
        addSubview(timestampView)
        timestampView.translatesAutoresizingMaskIntoConstraints = false
        timestampView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        timestampView.centerYAnchor.constraint(equalTo: subRegionLabel.centerYAnchor).isActive = true
        timestampView.updateText("2021.06.26")
    }
}

extension MountainInfoHistoryView {
    @objc
    private func didTapMoreButton(_ sender: UIButton) {
        print("more button tapped")
    }
}

extension MountainInfoHistoryView {
    private enum Layout {
        static let sideMargin: CGFloat = 20
    }
}
