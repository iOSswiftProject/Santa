//
//  searchBarVC.swift
//  santaProject
//
//  Created by 이병훈 on 2021/05/31.
//

import UIKit

class searchBarViewController: UIViewController {
    var tableView: UITableView!
    
    let data = searchBarData()
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
     
        return isActive && isSearchBarHasText

    }
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.makeLabel(frame: CGRect(x: 0, y: self.view.frame.height / 2, width: 100, height: 200))
        self.makeSearchBar()
        self.maketableView()
    }
    
    func makeLabel(frame: CGRect) {
        let label = UILabel(frame: frame)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "searchBarViewController"
        label.sizeToFit()
        label.center.x = self.view.frame.width / 2
        self.view.addSubview(label)
    }
    
    func makeSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "찾고싶은 산을 입력해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        
        //searchController에 UISearchResultsUpdating 프로토콜을 사용하기 위해서
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func maketableView() {
        tableView = UITableView()
        
        tableView.dataSource = self
        
        self.view.addSubview(tableView)

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mountinCell")
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView!,
                                                           attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top,
                                                           multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView!,
                                                           attribute: .bottom, relatedBy: .equal, toItem: self.view,
                                                           attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView!,
                                                           attribute: .leading, relatedBy: .equal, toItem: self.view,
                                                           attribute: .leading, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView!,
                                                           attribute: .trailing, relatedBy: .equal, toItem: self.view,
                                                           attribute: .trailing, multiplier: 1.0, constant: 0))
        
    }
}
extension searchBarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.data.filterValue.count : self.data.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mountinCell")!
        if self.isFiltering == false {
            cell.textLabel?.text = self.data.items[indexPath.row]
        } else {
            cell.textLabel?.text = self.data.filterValue[indexPath.row]
        }
        
        return cell
    }
}

extension searchBarViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
        self.data.filterValue = self.data.items.filter{ $0.localizedCaseInsensitiveContains(text)}
        
        self.tableView.reloadData()
    }
    
    
}

