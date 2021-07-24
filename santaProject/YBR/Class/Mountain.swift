//
//  Mountain.swift
//  santaProject
//
//  Created by yeongbinRo on 2021/06/05.
//

import Foundation
import MapKit

class Mountain: NSObject,MKAnnotation {
    
    var name: String?
    var peak: String?
    var height: Double?
    var depth1: String?
    var depth2: String?
    var id: Int32?
    var coordinate: CLLocationCoordinate2D
    var isFavorite: Bool?
    var isVisit: Bool?
    var date: String? // needed for delete query
    var title: String?
    var subtitle: String?
    
    init(name: String, peak: String, height: Double, depth1: String, depth2: String, latitude: Double, longtitude: Double, id: Int32, isFavorite: Int32, isVisit: Int32) {
        
        self.coordinate = CLLocationCoordinate2D.init(latitude: latitude, longitude: longtitude)
        self.name = name
        self.peak = peak
        self.height = height
        self.depth1 = depth1
        self.depth2 = depth2
        self.id = id
        self.isFavorite = (isFavorite != 0)
        self.isVisit = (isVisit != 0)
        self.title = name

    }
    
    
}
