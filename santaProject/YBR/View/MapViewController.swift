//
//  MapViewController.swift
//  santaProject
//
//  Created by yeongbinRo on 2021/06/05.
//

import UIKit
import MapKit

enum MapViewType {
    case searchResult
    case regionBased
}


class MapViewController: UIViewController {
    
    var mapViewType: MapViewType!
    
    let mapView:MKMapView = MKMapView.init(frame:.zero)
    
    let bottomSheetVC = UIViewController.init()
    let bottomHeight = CGFloat(200)
    var region: String?
    
    var depth1: String!
    var depth2: String!
    var location: CLLocation!
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var mountains:[Mountain]!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 2)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        mapView.register(MountainView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    
        // dummy process
        if depth1 == nil || depth2 == nil || location == nil {
            depth1 = "경기도"
            depth2 = "남양주시"
            location = CLLocation.init(latitude: 37.6311948, longitude: 127.1697305)
            
            self.navigationItem.title = depth1 + " " + depth2
            mapViewType = MapViewType.regionBased
            mountains  = DBInterface.shared.selectMountain(depth1: depth1, depth2: depth2)
            mapView.addAnnotations(mountains)
            //        self.navigationItem.title = depth1 + " " + depth2
            mapView.centerToLocation(location,regionRadius: 30_000)
        }

//        self.navigationController?.pushViewController(DummyViewController2(), animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
        setMapView()
        
        if mapViewType == MapViewType.regionBased {
            setBottomSheetVC()
            setupTableView()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //mapViewSetting
    func setMapView() {
        self.view.addSubview(mapView)
        mapView.isRotateEnabled = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        if mapViewType == .regionBased {
            mapView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
        } else {
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: bottomHeight).isActive = true
        }
    }
    
    
    //set BottomView
    func setBottomSheetVC() {
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        bottomSheetVC.view.backgroundColor = UIColor(hex: "CFCFCF")
//        let height = view.frame.height
//        let width = view.frame.width
//        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY - bottomHeight, width: width, height: height)
        bottomSheetVC.view.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetVC.view.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        bottomSheetVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bottomSheetVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomSheetVC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        bottomSheetVC.view.addGestureRecognizer(gesture)
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {

        let translation = recognizer.translation(in: self.view)
        let curY = bottomSheetVC.view.frame.origin.y
        let nxtY = translation.y
        
        if nxtY < 0 && curY > view.frame.height/2 { // darg to up
            
            self.bottomSheetVC.view.frame = CGRect(x: 0, y: curY + translation.y , width: view.frame.width, height: view.frame.height)
            
        } else if nxtY > 0 && curY <= view.frame.maxY - bottomHeight { // drag to down
            
            self.bottomSheetVC.view.frame = CGRect(x: 0, y: curY + translation.y, width: view.frame.width, height: view.frame.height)
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
    }

}


extension MapViewController: MKMapViewDelegate {
    
    /// Handling the Callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
//        guard let artwork = view.annotation as? Artwork else {
//            return
//        }
//                print("Callout touch")
    }
    
    // Handling annotation touch
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mountain = view.annotation as? Mountain {
            print(mountain)
//            let detailVC = MountainDetailTestViewController()
//            detailVC.mountain = mountain
//            detailVC.modalPresentationStyle = .currentContext
//            self.present(detailVC, animated: false, completion: nil)
        }
    }
    
    
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
        
    }
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mountains.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! MyListTableViewBookmarkCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.cellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        return Layout.topSpacing
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Layout.cellSpacing
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mountain = self.mountains[indexPath.row + indexPath.section]
        let cell = tableView.cellForRow(at: indexPath)
       
        cell?.layer.borderColor = UIColor.green.cgColor
        cell?.layer.borderWidth = 5
        
        mapView.centerToLocation(CLLocation(latitude: mountain.coordinate.latitude, longitude: mountain.coordinate.longitude), regionRadius: 8_000)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.borderWidth = 0
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyListTableViewBookmarkCell.self, forCellReuseIdentifier: "bookmarkCell")
        
        bottomSheetVC.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.leadingAnchor.constraint(equalTo: bottomSheetVC.view.leadingAnchor, constant: Layout.sideMargin).isActive = true
        tableView.trailingAnchor.constraint(equalTo: bottomSheetVC.view.trailingAnchor, constant: -Layout.sideMargin).isActive = true
        tableView.topAnchor.constraint(equalTo: bottomSheetVC.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomSheetVC.view.bottomAnchor).isActive = true

//        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(MyListTableViewBookmarkCell.self, forCellReuseIdentifier: "MyListTableViewCell")
    
    }
}


extension MapViewController {
    private enum Layout {
        static let sideMargin: CGFloat = 20
        static let topSpacing: CGFloat = 16
        static let cellSpacing: CGFloat = 12
        static let cellHeight: CGFloat = 96
    }
}
