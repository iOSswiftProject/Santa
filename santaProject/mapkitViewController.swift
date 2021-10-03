//
//  mapkitViewController.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/15.
//

import UIKit
import MapKit
import CoreLocation

class mapkitViewController: UIViewController {
    let locationManager = CLLocationManager()
    var mountains = [Mountain]()
    
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
        button.backgroundColor = .stOrange30
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(gotoregionVC), for: .touchUpInside)
        button.setTitle("어떤 지역으로 등산 가실건가요?", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addSubview(label)
        return button
    }()
    
    let MapView:MKMapView = MKMapView.init(frame:.zero)


    //mapViewSetting
    func setMapView() {
        self.view.addSubview(MapView)
        MapView.isRotateEnabled = false
        MapView.translatesAutoresizingMaskIntoConstraints = false
        MapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        MapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        MapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        MapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 200).isActive = true
    }
    
    func setRegionButton() {
        self.MapView.addSubview(regionButton)
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? -280
        regionButton.translatesAutoresizingMaskIntoConstraints = false
        regionButton.centerXAnchor.constraint(equalTo: self.MapView.centerXAnchor).isActive = true
        regionButton.widthAnchor.constraint(equalToConstant: 330).isActive = true
       // regionButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 200 + 30).isActive = true
        regionButton.heightAnchor.constraint(equalTo: regionButton.widthAnchor, multiplier: 1/6).isActive = true
//        regionButton.bottomAnchor.constraint(equalTo: RootTabBarController().tabBar.topAnchor, constant: -280).isActive = true
        regionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -tabBarHeight - 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapView()
        self.MapView.addSubview(textField)
        //self.searchBar.addSubview(searchButton)
       // self.MapView.bringSubviewToFront(searchButton)
        makeCustomTextField()
        setRegionButton()

        self.MapView.bringSubviewToFront(regionButton)
        MapView.register(MountainView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        setLocationManager()
        

        self.textField.delegate = self

        /* 체크를 위한 값 저장 */
        UserDefaults.standard.setValue(0, forKey: "region")

    }
    func makeCustomTextField() {
        let image = UIImage(named: "search")
        let imageView = UIImageView(frame: CGRect(x: 10, y: 14, width: 25, height: 25))
        imageView.image = image
        textField.frame = CGRect(x: 10, y: 60, width: 335, height: 40)
        textField.placeholder = "산 이름을 검색하세요"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.1
        textField.backgroundColor = .white
        textField.addLeftPadding()
        self.view.addSubview(textField)
        layoutOfTextFeild(textfield: textField)
        textField.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.textField.leadingAnchor, constant: 10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor).isActive = true
    }
    
    func layoutOfTextFeild(textfield: UITextField) {
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.centerXAnchor.constraint(equalTo: self.MapView.centerXAnchor).isActive = true
        textfield.topAnchor.constraint(equalTo: self.MapView.topAnchor, constant: 60).isActive = true
        textfield.widthAnchor.constraint(equalToConstant: 335).isActive = true
        textfield.heightAnchor.constraint(equalTo: textfield.widthAnchor, multiplier: 1/8).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        UINavigationBar.appearance().barTintColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        //
       // self.navigationController?.navigationBar.barTintColor = .white
        locationManager.startUpdatingLocation()

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

extension mapkitViewController: CLLocationManagerDelegate {
    
    func setLocationManager() {

        // request location authroization when the app is in use
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        updateUserLocation()
        
    }
    
    func updateUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func getAddress(location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
            guard let placemark = placemarks?.first, let dict = placemark.addressDictionary else {
                completion("",error)
                return
            }
            
            if let arr = dict["FormattedAddressLines"] as? NSArray {
                let address = arr[0] as! String
                print(address)
                completion(address, error)
            }
        }
//        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
//
//            guard let placemark = placemarks?.first, let dict = placemark.addressDictionary else {
//                completion("",error)
//                return
//            }
//
//            if let arr = dict["FormattedAddressLines"] as? NSArray {
//                let address = arr[0] as! String
//                print(address)
//                completion(address, error)
//            }
//
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        print("update")
        print(locationManager.location)

        if let location = locationManager.location {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 50_000, longitudinalMeters: 50_000)
            MapView.setRegion(coordinateRegion, animated: true)

            getAddress(location: location) { (addr, error) in
                let arr = addr?.split(separator: " ")
                print(arr)
                if arr?.count ?? 0 < 3 {
                    return
                }
                let depth1 = String(arr?[0] ?? "") // 도
                let addr1 = String(arr?[1] ?? "") // 시
                let addr2 = String(arr?[2] ?? "") // 구
                var depth2 = ""

                let region = RegionInfo.init(resource: "location2", offType: "json")

                let depth2Arr = region.getDepth2Arr(depth1: depth1)
                var temp = depth2Arr.filter({ $0 == addr1})
                depth2 = temp.count != 0 ? temp[0] : ""
                temp = depth2Arr.filter({ $0 == String(format: "%@ %@", addr1,addr2)})
                depth2 = temp.count != 0 ? temp[0] : depth2
                print(depth2)
                
                self.MapView.addAnnotations(DBInterface.shared.selectMountain(depth1: depth1, depth2: depth2))
      
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("fail")

    }
}
