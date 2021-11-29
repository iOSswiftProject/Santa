//
//  MyListHeaderView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/05.
//

import UIKit

protocol MyListHeaderViewDelegate: AnyObject {
    func myListHeaderViewDidSelectHistory()
    func myListHeaderViewDidSelectFavorite()
}

class MyListHeaderView: UIView {

    weak var delegate: MyListHeaderViewDelegate?

    private var historySelectConstraint: NSLayoutConstraint?
    private var favoriteSelectConstraint: NSLayoutConstraint?

    private let backgroundView = UIView()

    private let historyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: Layout.fontSize, weight: UIFont.Weight(0.7))

        let normalString = NSMutableAttributedString(string: "다녀온 산")
        let range = NSRange(location: 0, length: normalString.length)
        normalString.addAttribute(.foregroundColor, value: Layout.unselectedColor, range: range)
        normalString.addAttribute(.kern, value: Layout.kern, range: range)
        button.setAttributedTitle(normalString, for: .normal)

        let selectedString = NSMutableAttributedString(string: "다녀온 산")
        selectedString.addAttribute(.foregroundColor, value: Layout.selectedColor, range: range)
        selectedString.addAttribute(.kern, value: Layout.kern, range: range)
        button.setAttributedTitle(selectedString, for: .selected)

        button.isSelected = true

        return button
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: Layout.fontSize, weight: UIFont.Weight(0.7))
        let normalString = NSMutableAttributedString(string: "북마크")
        let range = NSRange(location: 0, length: normalString.length)
        normalString.addAttribute(.foregroundColor, value: Layout.unselectedColor, range: range)
        normalString.addAttribute(.kern, value: Layout.kern, range: range)
        button.setAttributedTitle(normalString, for: .normal)

        let selectedString = NSMutableAttributedString(string: "북마크")
        selectedString.addAttribute(.foregroundColor, value: Layout.selectedColor, range: range)
        selectedString.addAttribute(.kern, value: Layout.kern, range: range)
        button.setAttributedTitle(selectedString, for: .selected)

        return button
    }()

    private let selectView = UIView()

    init() {
        super.init(frame: .zero)
        setupBackgroundView()
        setupButtons()
        setupSelectView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

    private func setupBackgroundView() {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideMargin).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = Layout.cornerRadius
    }

    private func setupButtons() {
        addSubview(historyButton)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Layout.SelectView.sideMargin).isActive = true
        historyButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        historyButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        historyButton.addTarget(self, action: #selector(handleButtonSelect(_:)), for: .touchUpInside)

        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Layout.SelectView.sideMargin).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        favoriteButton.addTarget(self, action: #selector(handleButtonSelect(_:)), for: .touchUpInside)

        historyButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor).isActive = true
        historyButton.widthAnchor.constraint(equalTo: favoriteButton.widthAnchor, multiplier: 1).isActive = true

        historyButton.setTitleColor(.white, for: .normal)
    }

    private func setupSelectView() {
        insertSubview(selectView, aboveSubview: backgroundView)
        selectView.translatesAutoresizingMaskIntoConstraints = false
        selectView.widthAnchor.constraint(equalTo: historyButton.widthAnchor).isActive = true
        selectView.heightAnchor.constraint(equalToConstant: Layout.SelectView.height).isActive = true
        selectView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectView.backgroundColor = Layout.SelectView.backgroundColor

        selectView.layer.cornerRadius = Layout.SelectView.cornerRadius

        historySelectConstraint = selectView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                                      constant: Layout.SelectView.sideMargin)
        favoriteSelectConstraint = selectView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                                        constant: -Layout.SelectView.sideMargin)
        historySelectConstraint?.isActive = true
    }

    @objc
    private func handleButtonSelect(_ sender: UIButton) {
        switch sender {
        case historyButton:
            selectHistory()
            delegate?.myListHeaderViewDidSelectHistory()
        case favoriteButton:
            selectFavorite()
            delegate?.myListHeaderViewDidSelectFavorite()
        default:
            fatalError("Cannot be excecuted")
        }
    }

    func selectHistory() {
        UIView.animate(withDuration: Layout.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.favoriteSelectConstraint?.isActive = false
            self.historySelectConstraint?.isActive = true
            self.favoriteButton.isSelected = false
            self.historyButton.isSelected = true
            self.layoutIfNeeded()
        }
    }

    func selectFavorite() {
        UIView.animate(withDuration: Layout.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.historySelectConstraint?.isActive = false
            self.favoriteSelectConstraint?.isActive = true
            self.historyButton.isSelected = false
            self.favoriteButton.isSelected = true
            self.layoutIfNeeded()
        }
    }
}

extension MyListHeaderView {
    private enum Layout {
        static let sideMargin: CGFloat = 20
        static let spacing: CGFloat = 1
        static let cornerRadius: CGFloat = 12
        static let fontSize: CGFloat = 16

        static let selectedColor = UIColor.white
        static let unselectedColor = UIColor(hex: "#CECAC9")
        static let kern: CGFloat = -0.04

        enum SelectView {
            static let width: CGFloat = 161
            static let height: CGFloat = 44
            static let sideMargin: CGFloat = 6
            static let cornerRadius: CGFloat = 8
            static let backgroundColor = UIColor.stGreen50
        }

        static let animationDuration: TimeInterval = 0.3
    }
}
