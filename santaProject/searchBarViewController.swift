//
//  searchBarVC.swift
//  santaProject
//
//  Created by 이병훈 on 2021/05/31.
//

import UIKit
import MapKit
class searchBarViewController: UIViewController {
    
    var tableView: UITableView!

    
    let data = searchBarData()
    let searchController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()

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
        self.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self

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
//        self.makeSearchTextField()
//        self.makeNewSearchBar()
        self.makeSearchBar()
//        self.makeBarButtonItem()
        self.makeCancelView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }

    func makeBarButtonItem() {
//        let backBarButtonItem =  UIBarButtonItem(image: UIImage(named: "back_Button"), style: .plain, target: self, action: #selector(backToEx(_:)))
//        self.navigationItem.backBarButtonItem = backBarButtonItem
//        navigationItem.hidesBackButton = true;
//
//        let leftButton = UIBarButtonItem(image: UIImage(named: "back_Button"), style: .plain, target: self, action: #selector(backToEx(_:)))
        
//        leftButton.setImage(UIImage(named: "back_Button"), for: .normal)
//        leftButton.addTarget(self, action: #selector(backToEx(_:)), for: .touchUpInside)
//        leftButton.frame = CGRect(x: 0, y: 0, width: 53, height: 53)
        
//        let barbuttonItem = UIBarButtonItem(customView: leftButton)
        
//        self.navigationItem.leftBarButtonItem = leftButton
        
//        let rightButton = UIButton()
//        rightButton.setImage(UIImage(named: "santaTabImageSearchActive"), for: .normal)
//        rightButton.addTarget(self, action: #selector(searchButton(_:)), for: .touchUpInside)
//        rightButton.frame = CGRect(x: 0, y: 0, width: 53, height: 53)
//        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
//
//        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    @objc func searchButton(_ sender: Any) {
        print("searchButton")
    }
    
    @objc func backToEx(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print("custom Button")
        
    }
    func makeSearchTextField() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0
        
        let searchTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        searchTextField.placeholder = "산 이름을 검색하세요"
        searchTextField.layer.borderWidth = 0
        view.addSubview(searchTextField)
        self.navigationItem.titleView = view
    }
    
    func makeSearchBar() {
        self.searchController.searchBar.placeholder = "산, 지역, 이름을 검색하세요"
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
    func makeNewSearchBar() {
        searchBar.placeholder = "산, 지역, 이름을 검색하세요"
        searchBar.setImage(UIImage(named: "santaTabImageSearchActive"), for: .search, state: .normal)
        if #available(iOS 13.0, *) {
            self.searchBar.searchTextField.backgroundColor = UIColor.stCoolGray02

        } else {
            // Fallback on earlier versions
            self.searchBar.barTintColor = UIColor.stCoolGray02

        }
//        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        self.navigationItem.titleView = searchBar
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
extension searchBarViewController: UITableViewDataSource, SearchCellDelegate {
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
        
 
        let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as! [String]

        if self.isFiltering == false { // 최근검색어 -> 하단 셀이 단순 스트링
            let cell = tableView.dequeueReusableCell(withIdentifier: "mountinCell", for: indexPath) as? searchCell
            cell!.mountainLabel.text = searchedItems[indexPath.row]
            cell!.deleteButton.isHidden = false
//            cell!.deleteButton.addTarget(self, action: #selector(pushDeleteButton(_:)), for: .touchUpInside)
            cell!.delegate = self
            cell!.idx = indexPath.row
            // TODO: Delete 프로세스 추가.
            // 삭제는 index로 가야함. 단순 String 이기때문에 idx가 key값으로사용.
            // 추가로 searchArray에 용량제한과 중복 처리 추가필요
            return cell!
          
        } else { // 검색결과. -> 하단 셀이 Mountain객체.
//            cell!.mountainLabel.text = self.data.filterValue[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultCell
            let mountain = self.data.filteredValue[indexPath.row]
            cell?.mountain = mountain
            cell!.mountainLabel.text = String(format: "%@ %@", mountain.name ?? "", mountain.peak ?? "")
//            cell!.deleteButton.isHidden = true
            return cell!
        }
        
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
            self.data.searchItems.append(text.trimmingCharacters(in: [" "]))
            UserDefaults.standard.setValue(self.data.searchItems, forKey: "searchArray")
            
            print("touch Search Result!!")
            //TODO: 상세보기 프로세스 추가.
//            let detailViewController = DetailViewController(with: mountain)
//            navigationController?.pushViewController(detailViewController, animated: true)
            // TODO: 맵뷰로 변경
            let mapVC = MapViewController()
            mapVC.mapViewType = .searchResult
//            mountain.coordinate.latitude
//            mapVC.location = mountain.coordinate
            mapVC.mountains = [mountain]
            mapVC.location = CLLocation.init(latitude: mountain.coordinate.latitude, longitude: mountain.coordinate.longitude)
            navigationController?.pushViewController(mapVC, animated: true)
            print(self.data.searchItems)
            tableView.reloadData()
        } else {
            print("No filteringView")
            guard let searchedItems = UserDefaults.standard.array(forKey: "searchArray") as? [String] else { return }
            let text = searchedItems[indexPath.row]
//            print(text)
            searchController.searchBar.text = text
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.updateSearchResults(for: self.searchController)
            }
            
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
        self.data.filteredValue.sort { (m1, m2) -> Bool in
            guard let name1 = m1.name, let name2 = m2.name else { return false }
            return name1 < name2
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.reloadData()
        }
        
    }
    
    
}

extension searchBarViewController: UISearchBarDelegate {
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
