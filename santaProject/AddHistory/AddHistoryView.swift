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
        doneButton.widthAnchor.constraint(equalToConstant: Layout.buttonWidth).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)

        doneButton.backgroundColor = .stOrange40
    }

    private func setupCancelButton() {
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Layout.bottomMargin).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: Layout.buttonWidth).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        cancelButton.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)

        cancelButton.backgroundColor = .stCoolGray20
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
        static let buttonWidth: CGFloat = 163
        static let buttonHeight: CGFloat = 48
    }
}
