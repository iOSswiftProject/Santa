//
//  MountainView.swift
//  santaProject
//
//  Created by yeongbinRo on 2021/06/05.
//

import Foundation
import MapKit

class MountainView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let mountain = newValue as? Mountain else {
                return
            }
            
            if mountain.isVisit ?? false {
                image = #imageLiteral(resourceName: "SantaFlag")
            } else {
                image = #imageLiteral(resourceName: "SantaMt")
            }
            
            if mountain.isFavorite ?? false {
                addFavoriteButton()
            }

        }
    }
    
    func addFavoriteButton() {
        let imgView = UIImageView.init(frame: CGRect(x: self.frame.width - 10, y: 0, width: 10, height: 10))
        imgView.image = #imageLiteral(resourceName: "SantaBm")
        self.addSubview(imgView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        guard let mountain = annotation as? Mountain, let isVisit = mountain.isVisit else { return }
        
        var imgName = ""
        
        if selected {
            if isVisit {
                imgName = "SantaFlagBig"
            } else {
                imgName = "SantaMtBig"
            }
        } else {
            if isVisit {
                imgName = "SantaFlag"
            } else {
                imgName = "SantaMt"
            }
        }
        
        image = UIImage(named: imgName)

    }
}
