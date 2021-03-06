//
//  searchBarVC.swift
//  santaProject
//
//  Created by 이병훈 on 2021/05/31.
//

import UIKit
import MapKit

protocol SearchBarViewControllerDelegate: AnyObject {
    func didSelectMountain(_ mountain: Mountain)
}


class SearchBarViewController: UIViewController, UISearchControllerDelegate {

    weak var delegate: SearchBarViewControllerDelegate?
    var fromAddHistory = false

    var tableView: UITableView!

    
    let data = searchBarData()
    let searchController = UISearchController(searchResultsController: nil)

    var isFiltering: Bool {
        let isActive = searchController.isActive
        let isSearchBarHasText = searchController.searchBar.text?.isEmpty == false
     
        return isActive && isSearchBarHasText
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = nil

        self.navigationController?.navigationBar.isHidden = false
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self

        self.navigationController?.navigationBar.barTintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor.white
    
        let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as? [String]
        if searchedItems == nil {
            UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
        } else {
            self.data.searchItems = searchedItems!
        }
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.hidesBackButton = true;

        self.maketableView()

        self.makeSearchBar()
        self.makeCancelView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true

    }

    func makeSearchTextField() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 335, height: 40))
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0
        
        let searchTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 335, height:40))
        searchTextField.placeholder = "산 이름을 검색하세요"
        searchTextField.layer.borderWidth = 0
        view.addSubview(searchTextField)
        self.navigationItem.titleView = view
    }
    
    func makeSearchBar() {
        self.searchController.searchBar.placeholder = "산 이름을 검색하세요"
        self.searchController.obscuresBackgroundDuringPresentation = false

        //searchController에 UISearchResultsUpdating 프로토콜을 사용하기 위해서
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
//        self.navigationItem.searchController = searchController
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        if #available(iOS 13.0, *) {
            self.searchController.automaticallyShowsCancelButton = false
        } else {
            // Fallback on earlier versions
            self.searchController.searchBar.showsCancelButton = false
        }
        self.definesPresentationContext = true
        
        self.navigationItem.titleView = self.searchController.searchBar;
        //searchController
        //self.navigationItem.title = "Search"
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.setImage(UIImage(named: "santaTabImageSearchActive"), for: .search, state: .normal)
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = UIColor.stCoolGray02

        } else {
            // Fallback on earlier versions
            searchController.searchBar.barTintColor = UIColor.stCoolGray02

        }
    }
    
    func maketableView() {
        tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)

        self.tableView.register(searchCell.self, forCellReuseIdentifier: "mountinCell")
        self.tableView.register(SearchResultCell.self, forCellReuseIdentifier: "searchResultCell")

        /* 테이블 헤더 뷰 커스텀 하기 위한 */
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        self.tableView.translatesAutoresizingMaskIntoConstraints = false


        // TODO: 필요한 코드라면 살리기
//        if #available(iOS 15.0, *) {
////            tableView.sectionHeaderTopPadding = 0.0
//        } else {
//            // Fallback on earlier versions
//            self.automaticallyAdjustsScrollViewInsets = false;
//
//        }


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
    func makeCancelView() {
        let rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(pushDismissVC(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        rightBarButtonItem.tintColor = UIColor.stCoolGray90
    }
    
    @objc func pushDismissVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushDeleteButton(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        self.data.searchItems.remove(at: indexPath.row)
        NSLog("\(self.data.searchItems)" + " " + "\(indexPath.row)")
        tableView.deleteRows(at: [indexPath], with: .automatic)
        print("pushDeleteButton")
    }
    deinit {
        print("searchBarViewController deinit")
    }
    
   
}
extension SearchBarViewController: UITableViewDataSource, SearchCellDelegate {
    func deleteButtonDidTouched(cell: searchCell) {
        print("touch deleteButton!!")
//        self.data.searchItems.append(searchBarText!)
        // TODO: 테스트코드.제거할것
//        return
        guard let idx = cell.idx else { return }
        self.data.searchItems.remove(at: idx)
        UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
        self.tableView.reloadData()
    }
    
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
        
 
        var searchedItems = UserDefaults.standard.array(forKey: "searchArray") as! [String]
        searchedItems.reverse()

        if self.isFiltering == false { // 최근검색어 -> 하단 셀이 단순 스트링
            let cell = tableView.dequeueReusableCell(withIdentifier: "mountinCell", for: indexPath) as? searchCell
            cell!.mountainLabel.text = searchedItems[indexPath.row]
            cell!.deleteButton.isHidden = false
            cell!.delegate = self
            cell!.idx = searchedItems.count - indexPath.row - 1
            tableView.isScrollEnabled = false
            return cell!
          
        } else { // 검색결과. -> 하단 셀이 Mountain객체.
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultCell
            let mountain = self.data.filteredValue[indexPath.row]
            cell?.mountain = mountain
            cell!.mountainLabel.text = String(format: "%@ %@", mountain.name ?? "", mountain.peak ?? "")
            tableView.isScrollEnabled = true
            return cell!
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.searchController.searchBar.text == "" ? 60.0 : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader") else { return nil }
        let label = UILabel()
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16).isActive = true
        label.text = "최근 검색어"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .stGreen50
        headerView.backgroundView = UIView()
        return headerView
    }

}

extension SearchBarViewController: UITableViewDelegate {
    // MARK: tableCell touch Event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFiltering == true {
            let mountain = self.data.filteredValue[indexPath.row]
            let text = String(format: "%@ %@", mountain.name ?? "", mountain.peak ?? "")
            self.data.searchItems.append(text.trimmingCharacters(in: [" "]))
            UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
            
            print("touch Search Result!!")

            if fromAddHistory {
                delegate?.didSelectMountain(mountain)
                navigationController?.popViewController(animated: true)
            }
            else {
                let location = CLLocation.init(latitude: mountain.coordinate.latitude, longitude: mountain.coordinate.longitude)
                let mapVC = MapViewController.init(.searchResult, location, mountain)

                navigationController?.pushViewController(mapVC, animated: true)
                print(self.data.searchItems)
                tableView.reloadData()
            }


        } else {
            print("No filteringView")
            guard let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as? [String] else { return }
            let idx = searchedItems.count - indexPath.row - 1
            let text = searchedItems[idx]
            searchController.searchBar.text = text
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.updateSearchResults(for: self.searchController)
                self.searchController.isActive = true
                self.tableView.reloadData()
            }
            
        }
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("click log")
    }
}

// MARK: search Process
extension SearchBarViewController: UISearchResultsUpdating {
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
        self.data.filteredValue.sort { (m1, m2) -> Bool in
            guard let name1 = m1.name, let name2 = m2.name else { return false }
            return name1 < name2
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.reloadData()
        }
        
    }
    
    
}

extension SearchBarViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("click searchBar")
        let searchBarText = searchBar.text
        self.data.searchItems.append(searchBarText!)
        UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("click cancel")
    }
}
