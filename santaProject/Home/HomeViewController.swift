//
//  HomeViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/05/29.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHomeView()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "santaTabImageHomeInactive"), tag: 1)
        self.tabBarItem.selectedImage = UIImage(named: "santaTabImageHomeActive")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.update()
        homeView.tableView.reloadData()
        homeView.updateAccumulateHeight(homeViewModel.accumulateHeight)
    }

    private func setupHomeView() {
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.historyCellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier),
              let homeCell = cell as? HomeViewTableViewCell
        else { return UITableViewCell() }
        let cellModel = homeViewModel.historyCellModels[indexPath.row]
        cellModel.configure(cell: homeCell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        let safeAreaHeight = view.safeAreaInsets.top
        let tableViewheight = tableView.frame.height
        let mountainCellsHeight = homeViewModel.mountainCellsHeight
        let extraSpace = tableViewheight - mountainCellsHeight - safeAreaHeight
        return max(extraSpace, HomeViewTableViewHeaderView.height)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = homeViewModel.historyCellModels[indexPath.row].mountainImage
        return image?.size.height ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = HomeViewTableViewHeaderView.identifier
        guard section == 0,
              let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier),
              let homeHeader = header as? HomeViewTableViewHeaderView
        else { return nil }
        return homeHeader
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}
