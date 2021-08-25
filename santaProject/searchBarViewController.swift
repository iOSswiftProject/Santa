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
    let searchController = UISearchController(searchResultsController: nil)

    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
     
        return isActive && isSearchBarHasText
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.barTintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor.white
    
        let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as? [String]
        if searchedItems == nil {
            UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
        } else {
            self.data.searchItems = searchedItems!
        }
        
     
        self.maketableView()
        self.makeSearchBar()
        self.makeBarButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }

    func makeBarButtonItem() {
        let button = UIButton()
        button.setImage(UIImage(named: "back_Button"), for: .normal)
        button.addTarget(self, action: #selector(backToEx(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 53)
        
        let barbuttonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barbuttonItem
    }
    
    @objc func backToEx(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print("custom Button")
        
    }
    
    func makeSearchBar() {
        searchController.searchBar.placeholder = "산, 지역, 이름을 검색하세요"
        searchController.obscuresBackgroundDuringPresentation = false

        //searchController에 UISearchResultsUpdating 프로토콜을 사용하기 위해서
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        //searchController
        //self.navigationItem.title = "Search"
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func maketableView() {
        tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)

        self.tableView.register(searchCell.self, forCellReuseIdentifier: "mountinCell")
        /* 테이블 헤더 뷰 커스텀 하기 위한 */
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        tableView.tableFooterView = view
        
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView!,
                                                           attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top,
                                                           multiplier: 1.0, constant: 0.0))
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
    
    @objc func pushDeleteButton(_ sender: UIButton) {
//        let point = sender.convert(CGPoint.zero, to: tableView)
//        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
//        self.data.searchItems.remove(at: indexPath.row)
//        NSLog("\(self.data.searchItems)" + " " + "\(indexPath.row)")
//        tableView.deleteRows(at: [indexPath], with: .automatic)
        print("pushDeleteButton")
    }
    deinit {
        print("searchBarViewController deinit")
    }
    
   
}
extension searchBarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* 처음 들어갔을때 searchArray의 키값이 없으므로 nil을 반환하게 되는데 이것을 방지 하기 위해서*/
        guard let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as? [String] else {
            UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
            return 0
        }
//        return self.isFiltering ? self.data.filterValue.count : searchedItems.count
        return self.isFiltering ? self.data.filteredValue.count : searchedItems.count
    }
    
    //MARK: Make Cell. 최근검색어 또는 검색결과.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mountinCell", for: indexPath) as? searchCell
        
        let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as! [String]

        if self.isFiltering == false { // 최근검색어 -> 하단 셀이 단순 스트링
            cell!.mountainLabel.text = searchedItems[indexPath.row]
            cell!.deleteButton.isHidden = false
            cell!.deleteButton.addTarget(self, action: #selector(pushDeleteButton(_:)), for: .touchUpInside)
          
        } else { // 검색결과. -> 하단 셀이 Mountain객체.
//            cell!.mountainLabel.text = self.data.filterValue[indexPath.row]
            let mountain = self.data.filteredValue[indexPath.row]
            cell!.mountainLabel.text = String(format: "%@ %@", mountain.name ?? "", mountain.peak ?? "")
            cell!.deleteButton.isHidden = true
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        
        let view: UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = .white
            return view
        }()
        
        headerView?.textLabel?.text = "최근 검색어"
        headerView?.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        headerView?.textLabel?.textColor = UIColor.setColor(_names: .searchFontGreen)
        headerView?.backgroundView = view

        return headerView
    }

}

extension searchBarViewController: UITableViewDelegate {
    // MARK: tableCell touch Event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFiltering == true {
            //        let text = self.data.filterValue[indexPath.row]
            let mountain = self.data.filteredValue[indexPath.row]
            let text = String(format: "%@ %@", mountain.name ?? "", mountain.peak ?? "")
            self.data.searchItems.append(text)
            UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
            
            print("touch Search Result!!")
            //TODO: 상세보기 프로세스 추가.
            let detailViewController = DetailViewController(with: mountain)
            navigationController?.pushViewController(detailViewController, animated: true)

            print(self.data.searchItems)
            tableView.reloadData()
        } else {
            print("No filteringView")
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("click log")
    }
}

// MARK: search Process
extension searchBarViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
        self.data.filterValue = self.data.localItems.filter{ $0.localizedCaseInsensitiveContains(text)}
        
        self.data.filteredValue = self.data.mountainItems.filter({ (mountain) -> Bool in
            var str = ""
            if let name = mountain.name { str.append(name) }
            if let peak = mountain.peak { str.append(String(format: " %@", peak)) }
            return str.localizedCaseInsensitiveContains(text)
        })
        
        self.tableView.reloadData()
    }
    
    
}

extension searchBarViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("click searchBar")
        let searchBarText = searchBar.text
        self.data.searchItems.append(searchBarText!)
        UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
    }
}
