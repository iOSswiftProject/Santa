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
            setupCalloutView(mountain)

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
    
    func setupCalloutView(_ annotation: MKAnnotation) {
        
        self.canShowCallout = true
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setBackgroundImage(UIImage(named: "santaIconArrow"), for: .normal)
        
        btn.addTarget(self, action: #selector(touchRightButton), for: .touchUpInside)
        self.rightCalloutAccessoryView = btn

    }
    
    @objc
    func touchRightButton(sender: UIButton) {
        print("callout Button touch!")
    }
    
    
    //FIXME: 임시코드. 개선할 것
    override func layoutSubviews() {
        if !self.isSelected {
            return
        }
        
        for v in self.subviews {
            setLabelOfCallout(view: v)
        }
//        if self.subviews.count > 0 {
//            let calloutView = self.subviews[0]
//            setLabelOfCallout(view: calloutView)
//            if calloutView.subviews.count > 0 {
//                let bubbleView = calloutView.subviews[0]
//
//                setLabelOfCallout(view: bubbleView)
//            }
//        }

    }

    func setLabelOfCallout(view: UIView) {
        print("loop")
        print(view)
        
        //UILabel만 찾아 superView background color 바꾸기
        for v in view.subviews {
            
            if v.isKind(of: UILabel.self) {
                view.backgroundColor = .green
                
                guard let label = v as? UILabel, let text = label.text else { return }

                label.attributedText = setToAttributedString(str: text)
                
                
                return
            }
            
            setLabelOfCallout(view: v)
        }
    }
    
    
    
    func setToAttributedString(str: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: (str), attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor: UIColor.black, .kern: 1.0])
        
        if let idx = str.firstIndex(of: " ") {
            
            let pos = str.distance(from: str.startIndex, to: idx)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSMakeRange(pos, str.count-pos))
            
        }

        return attributedString
    }
    
}
