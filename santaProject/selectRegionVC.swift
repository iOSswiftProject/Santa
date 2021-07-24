//
//  selectRegionVC.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/16.
//

import UIKit

class selectRegionVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: self.view.frame.width / 3 - 10, height: 64) //100
        cv.delegate = self
        cv.dataSource = self
        cv.register(regionCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        cv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 96) //110
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
//        let image = UIImageView(image: UIImage(named: "yomi"))
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = UITableViewCell.SeparatorStyle.none
        tv.register(regionTableCell.classForCoder(), forCellReuseIdentifier: "regionCell")
        tv.backgroundColor = UIColor.setColor(_names: .lightlightgray)
        tv.tableHeaderView = collectionView
        tv.tableFooterView = UIImageView(image: UIImage(named: "santa"))
        return tv
    }()
//    lazy var image: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        let image = UIImage(named: "santa")
//        imageView.image = image
//        return imageView
//    }()
    
    let Data = regionData()

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

extension selectRegionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension selectRegionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let regionTest = UserDefaults.standard.integer(forKey: "region")
        if regionTest == 0 {
            return Data.firstData.count
        } else if regionTest == 1 {
            return Data.seoulItem.count
        }else if regionTest == 2 {
            return Data.gyeonggi.count
        } else if regionTest == 3{
            return Data.choongbuk.count
        } else  {
            return Data.seoulItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell") as? regionTableCell else {
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = UIColor.setColor(_names: .lightlightgray)
        /* 지역별 구분 */
        let regionTest = UserDefaults.standard.integer(forKey: "region")
        
        if regionTest == 0 {
            return UITableViewCell()
        } else if regionTest == 1 {
            cell.regionLabel.text = self.Data.seoulItem[indexPath.row].0
            cell.mountainLabel.text = self.Data.seoulItem[indexPath.row].1
        } else if regionTest == 2 {
            cell.regionLabel.text = self.Data.gyeonggi[indexPath.row]
            cell.mountainLabel.text = nil
        } else if regionTest == 3 {
            cell.regionLabel.text = self.Data.choongbuk[indexPath.row]
            cell.mountainLabel.text = nil
        } else {
            cell.regionLabel.text = self.Data.seoulItem[indexPath.row].0
            cell.mountainLabel.text = self.Data.seoulItem[indexPath.row].1
        }
        return cell
    }
}

extension selectRegionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let cell = collectionView.cellForItem(at: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? regionCell else {
            NSLog("collectionView cell의 인식자 error ")
            return
        }
        if indexPath.row == 0 {
            UserDefaults.standard.setValue(1, forKey: "region")
        } else if indexPath.row == 1 {
            UserDefaults.standard.setValue(2, forKey: "region")
        } else if indexPath.row == 2 {
            UserDefaults.standard.setValue(3, forKey: "region")
        } else {
            UserDefaults.standard.setValue(4, forKey: "region")
        }
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
        
        return Data.item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? regionCell else {
            NSLog("cell의 식별자 에러")
            return UICollectionViewCell()
        }
    
        cell.Tul.text = self.Data.item[indexPath.row]
        return cell
    }
    
    
}
