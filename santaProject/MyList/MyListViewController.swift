//
//  MyListViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/05.
//

import UIKit

class MyListViewController: UIViewController {

    enum ListCategory {
        case history
        case favorite
    }

    let models: [String] = [
        "History",
        "Favorite"
    ]

    private var listCategory: ListCategory = .history

    let headerView = MyListHeaderView()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func loadView() {
        super.loadView()

        setupHeaderView()
        setupCollectionView()
        view.backgroundColor = UIColor(hex: "CFCFCF")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 3)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 53).isActive = true

        headerView.delegate = self
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        collectionView.register(MyListCollectionViewCell.self, forCellWithReuseIdentifier: MyListCollectionViewCell.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CollectionView

extension MyListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCollectionViewCell.identifier, for: indexPath)
        guard  let listCollectionViewCell = cell as? MyListCollectionViewCell else { return UICollectionViewCell() }
        listCollectionViewCell.applyModel(models[indexPath.item])
        return cell
    }
}

extension MyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension MyListViewController: MyListHeaderViewDelegate {
    func myListHeaderViewDidSelectHistory() {
        listCategory = .history
    }

    func myListHeaderViewDidSelectFavorite() {
        listCategory = .favorite
    }
}
