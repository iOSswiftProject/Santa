//
//  MyListView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/05.
//

import UIKit

class MyListView: UIView {

    init() {
        super.init(frame: .zero)
        setupHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHeaderView() {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        headerView.backgroundColor = .gray
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}
