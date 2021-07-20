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
        if selected {
            image = image?.resizeImage(image: image!, targetSize: CGSize(width: 35, height: 35))
        } else {
            image = image?.resizeImage(image: image!, targetSize: CGSize(width: 28, height: 28))
        
        }
    }
}
