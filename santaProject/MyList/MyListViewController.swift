//
//  MyListViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/05.
//

import UIKit

class MyListViewController: UIViewController {
    let viewModels: [MyListTableViewModel] = [
        MyListHistoryTableViewModel(),
        MyListFavoriteTableViewModel(),
    ]

    var historyTableViewModel: MyListHistoryTableViewModel {
        viewModels[0] as! MyListHistoryTableViewModel
    }

    var favoriteTableViewModel: MyListFavoriteTableViewModel {
        viewModels[1] as! MyListFavoriteTableViewModel
    }

    private var selectedIndex: Int = 0 {
        didSet {
            guard selectedIndex != oldValue else { return }
            selectItem(at: selectedIndex)
        }
    }

    let headerView = MyListHeaderView()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = false
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
        self.tabBarItem = UITabBarItem(title: "나의 산", image: UIImage(named: "santaTabImageListInactive"), tag: 3)
        self.tabBarItem.selectedImage = UIImage(named: "santaTabImageListActive")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.Header.topMargin).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Layout.Header.height).isActive = true

        headerView.delegate = self
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        collectionView.register(MyListCollectionViewCell.self, forCellWithReuseIdentifier: MyListCollectionViewCell.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func selectItem(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        switch index {
        case 0:
            headerView.selectHistory()
        case 1:
            headerView.selectFavorite()
        default:
            fatalError("cannot be executed")
        }
    }
}

extension MyListViewController: MyListCollectionViewCellDelegate {
    func didTapAddHistoryButton() {
        let viewController = AddHistoryViewController()
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    func didTapMoreButtonForHistoryIndexPath(_ indexPath: IndexPath) {
        func removeHistory(at indexPath: IndexPath) {
            guard let collectionViewCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)),
                  let collectionViewHistoryCell = collectionViewCell as? MyListCollectionViewCell
            else { return }

            // TODO: remove with history id
            let mountain = historyTableViewModel.history[indexPath.section]
            guard let id = mountain.id, let date = mountain.date else { return }
            DBInterface.shared.deleteLog(mountainId: id, date: date)

            historyTableViewModel.removeHistory(at: indexPath.section)
            collectionViewHistoryCell.removeHistory(at: indexPath.section)

            if historyTableViewModel.countFor(id: id) == 0 {
                DBInterface.shared.updateIsVisit(mountainId: id, isVisit: false)
                favoriteTableViewModel.updateVisited(id: Int(id), visited: false)
                collectionView.reloadItems(at: [IndexPath(row: 1, section: 0)])
            }
        }

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let destructiveAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            removeHistory(at: indexPath)
        }
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(destructiveAction)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
    }
}

extension MyListViewController: AddHistoryViewControllerDelegate {
    func historyViewController(_ controller: AddHistoryViewController, addedHistoryWith mountain: Mountain, dateString: String) {
        guard let mountainId = mountain.id else { return }

        DBInterface.shared.insertLOG(mountainId: mountainId, date: dateString)

        // TODO: handle in DB?
        DBInterface.shared.updateIsVisit(mountainId: mountainId, isVisit: true)

        historyTableViewModel.addHistory(mountain: mountain, date: dateString)
        favoriteTableViewModel.updateVisited(id: Int(mountainId), visited: true)
        collectionView.reloadData()

    }
}

// MARK: - CollectionView

extension MyListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCollectionViewCell.identifier, for: indexPath)
        guard  let listCollectionViewCell = cell as? MyListCollectionViewCell else { return UICollectionViewCell() }
        listCollectionViewCell.delegate = self
        listCollectionViewCell.applyViewModel(viewModels[indexPath.item])
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating else { return }
        let width = scrollView.frame.width
        let pageIndex = Int((scrollView.contentOffset.x + width / 2) / width)
        selectedIndex = pageIndex
    }
}

extension MyListViewController: MyListHeaderViewDelegate {
    func myListHeaderViewDidSelectHistory() {
        selectItem(at: 0)
    }

    func myListHeaderViewDidSelectFavorite() {
        selectItem(at: 1)
    }
}

extension MyListViewController {
    private enum Layout {
        enum Header {
            static let topMargin: CGFloat = 20
            static let height: CGFloat = 56
        }
    }
}
