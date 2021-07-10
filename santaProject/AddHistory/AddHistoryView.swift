//
//  AddHistoryView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/10.
//

import UIKit

protocol AddHistoryViewDelegate: AnyObject {
    func didTapDoneButton()
    func didTapCancelButton()
}

class AddHistoryView: UIView {

    weak var delegate: AddHistoryViewDelegate?

    let doneButton = UIButton()
    let cancelButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupDoneButton()
        setupCancelButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDoneButton() {
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideMargin).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Layout.bottomMargin).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: Layout.LowerButton.width).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: Layout.LowerButton.height).isActive = true
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)

        doneButton.backgroundColor = .stOrange40
        doneButton.layer.cornerRadius = Layout.LowerButton.cornerRadius

        guard let label = doneButton.titleLabel else { return }
        label.font = .systemFont(ofSize: Layout.LowerButton.fontSize, weight: Layout.LowerButton.weight)
        label.textColor = .stCoolGray00
        let attrString = NSMutableAttributedString(string: "완료")
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: Layout.LowerButton.letterSpacing, range: range)
        doneButton.setAttributedTitle(attrString, for: .normal)
    }

    private func setupCancelButton() {
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Layout.bottomMargin).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: Layout.LowerButton.width).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: Layout.LowerButton.height).isActive = true
        cancelButton.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)

        cancelButton.backgroundColor = .stCoolGray20
        cancelButton.layer.cornerRadius = Layout.LowerButton.cornerRadius

        guard let label = cancelButton.titleLabel else { return }
        label.font = .systemFont(ofSize: Layout.LowerButton.fontSize, weight: Layout.LowerButton.weight)
        label.textColor = .stCoolGray70
        let attrString = NSMutableAttributedString(string: "취소")
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: Layout.LowerButton.letterSpacing, range: range)
        cancelButton.setAttributedTitle(attrString, for: .normal)
    }



    @objc
    private func didTapDoneButton(_ sender: UIButton) {
        delegate?.didTapDoneButton()
    }

    @objc
    private func didTapCancelButton(_ sender: UIButton) {
        delegate?.didTapCancelButton()
    }
}

extension AddHistoryView {
    private enum Layout {
        static let bottomMargin: CGFloat = 40
        static let sideMargin: CGFloat = 20

        enum LowerButton {
            static let width: CGFloat = 163
            static let height: CGFloat = 48
            static let cornerRadius: CGFloat = 12
            static let fontSize: CGFloat = 16
            static let letterSpacing: CGFloat = -0.04
            static let weight = UIFont.Weight(700)
        }


    }
}
