//
//  MyListViewController.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/05.
//

import UIKit

class MyListViewController: UIViewController {

    override func loadView() {
        super.loadView()

        // TODO: Retain views in controller?
        let listView = MyListView()
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        view = listView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 3)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension MyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.identifier) as? MyListTableViewCell else { return UITableViewCell() }
        // TODO: update content
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: apply data model
        10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

}

extension MyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MyListTableViewCell.Layout.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        MyListTableView.Layout.cellPadding
    }
    
}
