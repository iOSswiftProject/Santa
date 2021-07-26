//
//  regionViewController.swift
//  santaProject
//
//  Created by 이병훈 on 2021/05/27.
//

import UIKit

class regionViewController: UIViewController {
    var collectionView: UICollectionView!
    
    let Data = regionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 10

        let twoPicture = UIScreen.main.bounds.width / 2
        layout.itemSize = CGSize(width: twoPicture - 50 , height: 200)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
            
        collectionView.register(regionCell.classForCoder(), forCellWithReuseIdentifier: "cell")

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension regionViewController: UICollectionViewDataSource {
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

extension regionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchVC = searchBarViewController()
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}
