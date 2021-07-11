//
//  mapkitViewController.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/15.
//

import UIKit
import MapKit

class mapkitViewController: UIViewController {
    let textField = UITextField()

    lazy var searchButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.addTarget(self, action: #selector(preshSearchBar), for: .touchUpInside)
        //button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var searchView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "산이름을 검색하세요"
        searchBar.layer.cornerRadius = 10
        searchBar.frame = CGRect(x: 0, y: 30, width: 300, height: 50)
        searchBar.center.x = self.MapView.frame.width / 2
        return searchBar
    }()
    
    lazy var regionButton: UIButton = {
        let button = UIButton()
        let label = UILabel()
        button.frame = CGRect(x: 30, y: 300, width: 335, height: 63)
        button.backgroundColor = UIColor.setColor(_names: .greengreen)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(gotoregionVC), for: .touchUpInside)
        button.setTitle("어떤 지역으로 등산 가실건가요?", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addSubview(label)
        return button
    }()
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCustomTextField()
        //self.MapView.addSubview(searchBar)
        self.MapView.addSubview(textField)
        self.MapView.addSubview(regionButton)
        //self.searchBar.addSubview(searchButton)
       // self.MapView.bringSubviewToFront(searchButton)

        self.textField.delegate = self
        regionButton.translatesAutoresizingMaskIntoConstraints = false
        regionButton.centerXAnchor.constraint(equalTo: self.MapView.centerXAnchor).isActive = true
        regionButton.widthAnchor.constraint(equalToConstant: 330).isActive = true
        regionButton.heightAnchor.constraint(equalTo: regionButton.widthAnchor, multiplier: 1/6).isActive = true
        regionButton.bottomAnchor.constraint(equalTo: self.MapView.bottomAnchor, constant: -26).isActive = true
//        regionButton.leadingAnchor.constraint(equalTo: self.MapView.leadingAnchor, constant: 50).isActive = true
//        regionButton.trailingAnchor.constraint(equalTo: self.MapView.trailingAnchor, constant: -50).isActive = true
        /* 체크를 위한 값 저장 */
        UserDefaults.standard.setValue(0, forKey: "region")

    }
        func makeCustomTextField() {
            let image = UIImage(named: "search")
            let imageView = UIImageView(frame: CGRect(x: 293, y: 16, width: 25, height: 25))
            imageView.image = image
            textField.frame = CGRect(x: 40, y: 60, width: 335, height: 52)
            textField.placeholder = "산 이름을 검색하세요"
            textField.layer.cornerRadius = 25
            textField.layer.borderWidth = 0.1
            textField.backgroundColor = .white
            textField.addLeftPadding()
            self.view.addSubview(textField)
            textField.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor, constant: -23).isActive = true
            imageView.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor).isActive = true
        }
    override func viewWillAppear(_ animated: Bool) {
        UINavigationBar.appearance().barTintColor = UIColor.white
        /* navigationBar를 보이다가 숨김처리하면 뒤에 background에 검은색 화면이 등장*/
        self.navigationController?.navigationBar.isHidden = true
        //
       // self.navigationController?.navigationBar.barTintColor = .white

    }
    @objc func preshSearchBar() {
        let serachViewController = searchBarViewController()
        navigationController?.pushViewController(serachViewController, animated: true)
    }
    @objc func gotoregionVC() {
        let selectViewController = selectRegionVC()
        navigationController?.pushViewController(selectViewController, animated: true)
    }
}
extension mapkitViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = searchBarViewController()
        textField.resignFirstResponder()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
