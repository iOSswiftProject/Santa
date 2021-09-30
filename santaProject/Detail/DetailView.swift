//
//  DetailView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func detailViewDidTapBookmarkButton(_ detailView: DetailView)
}

class DetailView: UIView {

    weak var delegate: DetailViewDelegate?

    let imageView = UIImageView()
    let mountainInfoView = MountainInfoBookmarkView()
    let emptyInfoView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupImageView()
        setupMountainInfoView()
        setupEmptyView()
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

        view.delegate = self
    }

    private func setupEmptyView() {
        addSubview(emptyInfoView)
        emptyInfoView.translatesAutoresizingMaskIntoConstraints = false
        emptyInfoView.topAnchor.constraint(equalTo: mountainInfoView.bottomAnchor, constant: 61).isActive = true
        emptyInfoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        let imageView = UIImageView(image: UIImage(named: "detail_empty"))
        let label = UILabel()

        emptyInfoView.addSubview(imageView)
        emptyInfoView.addSubview(label)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.leadingAnchor.constraint(equalTo: emptyInfoView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: emptyInfoView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: emptyInfoView.topAnchor).isActive = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        label.bottomAnchor.constraint(equalTo: emptyInfoView.bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: emptyInfoView.centerXAnchor).isActive = true
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .stCoolGray60

        let attrString = NSMutableAttributedString(string: "산에 대한 정보가 없습니다.")
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: -0.02, range: range)
        label.attributedText = attrString
    }

    func setupDetailInfoView(with detailInfo: DetailInfo) {

    }
}

extension DetailView: MountainInfoBookmarkViewDelegate {
    func bookmarkViewDidTapBookmarkButton(_ bookmarkView: MountainInfoBookmarkView) {
        delegate?.detailViewDidTapBookmarkButton(self)
    }
}
