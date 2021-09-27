//
//  MapViewController.swift
//  santaProject
//
//  Created by yeongbinRo on 2021/06/05.
//

import UIKit
import MapKit

enum MapViewType {
    case searchResult   //mountain, location 필요
    case regionBased    // depth1, depth2, location 필요
}

class MapViewController: UIViewController {
    
    var mapViewType: MapViewType!
    
    let mapView:MKMapView = MKMapView.init(frame:.zero)
    
    let bottomSheetVC = UIViewController.init()
    let bottomHeight = CGFloat(200)
    let bottomEmptyImageView = UIView()
    var region: String?
    
    var depth1: String!
    var depth2: String!
    var location: CLLocation!
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var mountains:[Mountain]!
    
    // regionBased init
    init(_ mapViewType: MapViewType,_ depth1: String, _ depth2: String, location: CLLocation) {
        super.init(nibName: nil, bundle: nil)
        self.mapViewType = mapViewType
        self.depth1 = depth1
        self.depth2 = depth2
        self.location = location
    }
    
    // searchResult init
    init(_ mapViewType: MapViewType, _ location: CLLocation, _ mountain: Mountain) {
        super.init(nibName: nil, bundle: nil)
        self.mapViewType = mapViewType
        self.location = location
        self.mountains = [mountain]
    }
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
////        self.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 2)
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        mapView.register(MountainView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    
        mapView.centerToLocation(location,regionRadius: 30_000)
        if mapViewType == .regionBased {
            self.navigationItem.title = depth1 + " " + depth2
            mountains  = DBInterface.shared.selectMountain(depth1: depth1, depth2: depth2)
            mountains.sort { (m1, m2) -> Bool in
                guard let name1 = m1.name, let name2 = m2.name else { return false }
                return name1 < name2
            }
            mapView.addAnnotations(mountains)
        } else {
        
            mapView.addAnnotations(mountains)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.tabBarController?.tabBar.isHidden = true
        setupMapView()
        
        if mapViewType == MapViewType.regionBased {
            setupBottomSheetVC()
            setupTableView()
            setupBottomBackground()
        }else {
            setupDetailView()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //mapViewSetting
    func setupMapView() {
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
    func setupBottomSheetVC() {
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        bottomSheetVC.view.backgroundColor = UIColor.stCoolGray25
        bottomSheetVC.view.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetVC.view.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        bottomSheetVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bottomSheetVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomSheetVC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }

    // set backgroundView of BottomView
    func setupBottomBackground() {
        let view = bottomEmptyImageView
        bottomSheetVC.view.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: bottomSheetVC.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: bottomSheetVC.view.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: bottomSheetVC.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomSheetVC.view.bottomAnchor).isActive = true
        
        // Empty 이미지
        let imageView = UIImageView(image: UIImage(named: "history_empty"))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 114).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -111).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -164).isActive = true
        
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 49).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.font = .systemFont(ofSize: 16, weight: .regular)
        let attrString = NSMutableAttributedString(string: "이 지역은 산이 없습니다.")
        let range = NSRange(location: 0, length: attrString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        paragraphStyle.alignment = .center
        attrString.addAttribute(.kern, value: -0.08, range: range)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        label.attributedText = attrString
        
        view.isHidden = true
    }
    
    func showEmptyBackground() {
        bottomEmptyImageView.isHidden = false
    }
    
    func hideEmptyBackground() {
        bottomEmptyImageView.isHidden = true
    }
    
    func setupDetailView() {
        let mountainInfoView = MountainInfoBookmarkView()
        self.view.addSubview(mountainInfoView)
        mountainInfoView.translatesAutoresizingMaskIntoConstraints = false
        mountainInfoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        mountainInfoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        mountainInfoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        mountainInfoView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        
        mountainInfoView.backgroundColor = .white
        mountainInfoView.layer.cornerRadius = 12
        mountainInfoView.layer.shadowRadius = 24
        mountainInfoView.layer.shadowColor = UIColor.black.cgColor
        mountainInfoView.layer.shadowOpacity = 0.12

    }

}


extension MapViewController: MKMapViewDelegate {
    
    /// Handling the Callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let mountain = view.annotation as? Mountain else {
            return
        }
        let detailVC = DetailViewController.init(with: mountain)
        self.navigationController?.pushViewController(detailVC, animated: true)
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
        if mountains.count == 0 {
            showEmptyBackground()
        } else {
            hideEmptyBackground()
        }
        
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
        
        // Apply new Cell Model
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! MyListTableViewBookmarkCell
//        let cell = MyListTableViewBookmarkCell()
        cell.selectionStyle = .none

        let mountain = mountains[indexPath.section]
        let cellModel = MyListTableViewBookmarkCellModel.init(with: mountain)
        cellModel.configure(cell)
        
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
       
        cell?.layer.borderColor = UIColor(hex: "#007F36").cgColor
        cell?.layer.borderWidth = 2
        
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
        
        tableView.tableFooterView = UIView.init(frame: .zero)
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
