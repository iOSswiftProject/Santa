//
//  MyListHeaderView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/05.
//

import UIKit

class MyListHeaderView: UIView {

    private var historySelectConstraint: [NSLayoutConstraint] = []
    private var favoriteSelectConstraint: [NSLayoutConstraint] = []

    private let historyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("최근", for: .normal)
        return button
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("북마크", for: .normal)
        return button
    }()

    private let selectBar = UIView(frame: .zero)


    init() {
        super.init(frame: .zero)
        setupButtons()
        setupSelectBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

    private func setupButtons() {
        addSubview(historyButton)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideMargin).isActive = true
        historyButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        historyButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        historyButton.addTarget(self, action: #selector(handleButtonSelect(_:)), for: .touchUpInside)

        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        favoriteButton.addTarget(self, action: #selector(handleButtonSelect(_:)), for: .touchUpInside)

        historyButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -Layout.innerMargin).isActive = true
        historyButton.widthAnchor.constraint(equalTo: favoriteButton.widthAnchor, multiplier: 1).isActive = true

        historyButton.setTitleColor(.selectedColor, for: .normal)
    }

    private func setupSelectBar() {
        addSubview(selectBar)
        selectBar.translatesAutoresizingMaskIntoConstraints = false
        selectBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        selectBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectBar.backgroundColor = .selectedColor

        historySelectConstraint = [
            selectBar.leadingAnchor.constraint(equalTo: historyButton.leadingAnchor),
            selectBar.trailingAnchor.constraint(equalTo: historyButton.trailingAnchor)
        ]
        favoriteSelectConstraint = [
            selectBar.leadingAnchor.constraint(equalTo: favoriteButton.leadingAnchor),
            selectBar.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor)
        ]
        historySelectConstraint.forEach{ $0.isActive = true }
    }

    @objc
    private func handleButtonSelect(_ sender: UIButton) {
        switch sender {
        case historyButton:
            selectHistory()
        case favoriteButton:
            selectFavorite()
        default:
            fatalError("Cannot be excecuted")
        }
    }

    private func selectHistory() {
        UIView.animate(withDuration: Layout.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.favoriteSelectConstraint.forEach { $0.isActive = false }
            self.historySelectConstraint.forEach { $0.isActive = true }
            self.favoriteButton.setTitleColor(.black, for: .normal)
            self.historyButton.setTitleColor(.selectedColor, for: .normal)
            self.layoutIfNeeded()
        }
    }

    private func selectFavorite() {
        UIView.animate(withDuration: Layout.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.historySelectConstraint.forEach { $0.isActive = false }
            self.favoriteSelectConstraint.forEach { $0.isActive = true }
            self.historyButton.setTitleColor(.black, for: .normal)
            self.favoriteButton.setTitleColor(.selectedColor, for: .normal)
            self.layoutIfNeeded()
        }
    }
}

extension MyListHeaderView {
    private enum Layout {
        static let sideMargin: CGFloat = 20
        static let innerMargin: CGFloat = 15

        static let animationDuration: TimeInterval = 0.1
    }
}
