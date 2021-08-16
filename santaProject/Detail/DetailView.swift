//
//  DetailView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func detailViewDidTapBackButton(_ detailView: DetailView)
}

class DetailView: UIView {

    weak var delegate: DetailViewDelegate?

    let imageView = UIImageView()
    let mountainInfoView = MountainInfoBookmarkView()
    let textArea = UITextView()
    let backButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupImageView()
        setupMountainInfoView()
        setupTextArea()
        setupBackButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 212).isActive = true

        imageView.backgroundColor = .gray
    }

    private func setupMountainInfoView() {
        let view = mountainInfoView
        view.backgroundColor = .white
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        view.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -46).isActive = true
        view.heightAnchor.constraint(equalToConstant: 96).isActive = true
        view.layer.cornerRadius = 12
        view.layer.shadowRadius = 24
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.12
    }

    private func setupTextArea() {
        addSubview(textArea)
        textArea.translatesAutoresizingMaskIntoConstraints = false
        textArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        textArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        textArea.topAnchor.constraint(equalTo: mountainInfoView.bottomAnchor, constant: 32).isActive = true
        textArea.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textArea.isEditable = false

        textArea.backgroundColor = .lightGray
    }

    private func setupBackButton() {
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        backButton.setImage(UIImage(named: "santaBackButton"), for: .normal)
        backButton.tintColor = .stCoolGray70
    }

    @objc
    private func didTapBackButton() {
        delegate?.detailViewDidTapBackButton(self)
    }
}
