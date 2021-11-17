//
//  selectRegionVC.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/16.
//

import UIKit
import MapKit

class selectRegionVC: UIViewController {
    
    var regionInfo: RegionInfo = {
        return RegionInfo.init(resource: "location2", offType: "json")
    }()
    
    let Data = regionData()
    lazy var depth2Data: [String] = {
        regionInfo.getDepth2Arr(depth1: "서울특별시")
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 64) //100
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(regionCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        cv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 96) //110
        cv.backgroundColor = .white
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let indexPath = IndexPath(item: 0, section: 0)
        DispatchQueue.main.async {
           cv.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = UITableViewCell.SeparatorStyle.none
        tv.register(regionTableCell.classForCoder(), forCellReuseIdentifier: "regionCell")
        tv.backgroundColor = UIColor.setColor(_names: .lightlightgray)
        tv.tableHeaderView = collectionView
        tv.tableFooterView = UIImageView(image: UIImage(named: "santa"))
        tv.bounces = false
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setView()
        setAutolayout()
//        setImageViewlayout()
        collectionView.reloadData()
        tableView.reloadData()
//        if(UserDefaults.standard.integer(forKey: "region") == 0) {
//            tableView.tableFooterView = image
//        }
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor.white

        /* 내비게이션 바 줄 없애기*/
       // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "지역별 검색"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .white
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        /* 화면 등장했을떄 아무것도 안뜨게 하기 위해서*/
        UserDefaults.standard.setValue(0, forKey: "region")
        super.viewDidDisappear(animated)
        UIView.setAnimationsEnabled(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    deinit {
        print("selectRegionVC deinit")
    }
}
extension selectRegionVC {
    func setView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
    }
    func setAutolayout() {
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: TableView Delegate
extension selectRegionVC: UITableViewDelegate, RegionTableCellDelegate {
    func didTouchNextButton(cell: regionTableCell) {
//        guard let depth1Row = collectionView.indexPathsForSelectedItems?[0].row else { return }
//        let depth1 = regionInfo.getDepth1Arr()[depth1Row]
//        guard let idx = cell.idx else { return }
//        let depth2 = depth2Data[idx]
//        
//        let loc = regionInfo.getLocation(depth1: depth1, depth2: depth2)
//        let location = CLLocation.init(latitude: loc[0], longitude: loc[1])
//        let mapViewController = MapViewController.init(.regionBased, depth1, depth2, location: location)
//        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let depth1Row = collectionView.indexPathsForSelectedItems?[0].row else { return }
        let depth1 = regionInfo.getDepth1Arr()[depth1Row]
//        let depth2Arr = regionInfo.getDepth2Arr(depth1: depth1)
        let depth2 = depth2Data[indexPath.row]
        let loc = regionInfo.getLocation(depth1: depth1, depth2: depth2)
        
        let location =  CLLocation.init(latitude: loc[0], longitude: loc[1])
        let mapViewController = MapViewController.init(.regionBased, depth1, depth2, location: location)
        self.navigationController?.pushViewController(mapViewController, animated: true);

    }
}

extension selectRegionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depth2Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell") as? regionTableCell else {
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = UIColor.setColor(_names: .lightlightgray)
        cell.delegate = self
        cell.idx = indexPath.row
        cell.regionLabel.text = depth2Data[indexPath.row]
        var depth1Row = 0
        if collectionView.indexPathsForSelectedItems?.count != 0 {
            depth1Row = collectionView.indexPathsForSelectedItems?[0].row ?? 0
        }
        let depth1 = regionInfo.getDepth1Arr()[depth1Row]
        let depth2 = depth2Data[indexPath.row]
        let mountains = DBInterface.shared.selectMountain(depth1: depth1, depth2: depth2)
  
        var mountainListLabel =  ""
        
        if !mountains.isEmpty {

            for (idx, mountain) in mountains.enumerated() {
                if idx == 2 {
                    mountainListLabel.append(" 등")
                    break
                }
                if idx == 1 {
                    mountainListLabel.append(", ")
                }
                mountainListLabel.append(mountain.name ?? "")
            }
            
        }
        
        cell.mountainLabel.text = mountainListLabel

        return cell
    }
}

//MARK: CollectionView Delegate
extension selectRegionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let cell = collectionView.cellForItem(at: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? regionCell else {
            NSLog("collectionView cell의 인식자 error ")
            return
        }

        let depth1 = regionInfo.getDepth1Arr()[indexPath.row]
        depth2Data = regionInfo.getDepth2Arr(depth1: depth1)
        
        
        if(UserDefaults.standard.integer(forKey: "region") != 0) {
            let view = UIView()
            tableView.tableFooterView = view
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        cell.contentView.layer.cornerRadius = 10
        tableView.reloadData()
    }

}
extension selectRegionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return Data.item.count
        return regionInfo.getDepth1Arr().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? regionCell else {
            NSLog("cell의 식별자 에러")
            return UICollectionViewCell()
        }
    
//        cell.Tul.text = self.Data.item[indexPath.row]
        let depth1 = regionInfo.getDepth1Arr()[indexPath.row]
        cell.Tul.text = regionInfo.getDepth1(depth1: depth1)
        return cell
    }
    
    
}
