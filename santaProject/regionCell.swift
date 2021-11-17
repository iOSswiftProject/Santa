//
//  regionCell.swift
//  santaProject
//
//  Created by 이병훈 on 2021/05/27.
//

import UIKit

class regionCell: UICollectionViewCell {
    var Tul: UILabel!
    var Img: UIImageView!
    
    
    override var isSelected: Bool {
           didSet{
               if isSelected {
                self.contentView.backgroundColor = .stGreen50
                self.Tul.textColor = .stCoolGray00
               }
               else {
                self.contentView.backgroundColor = .stCoolGray02
                self.Tul.textColor = .stCoolGray50
               }
           }
       }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.cornerRadius = 10
        self.contentView.backgroundColor = UIColor.setColor(_names: .searchUnselectback)
        makeImage()
        makeLabel()
    }

    required init?(coder aDecorder: NSCoder) {
        fatalError("init(corder:) has not been implemented")
       
    }
    func makeLabel() {
        Tul = UILabel()
        contentView.addSubview(Tul)
        
        Tul.textColor = UIColor.setColor(_names: .searchUnselectFont)
        Tul.font = UIFont.boldSystemFont(ofSize: 20)
        Tul.textAlignment = .center
        Tul.translatesAutoresizingMaskIntoConstraints = false
        
        Tul.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        Tul.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        Tul.sizeToFit()
    }
    func makeImage() {
        Img = UIImageView()
        contentView.addSubview(Img)

        Img.layer.cornerRadius = Img.frame.width / 2
        Img.layer.borderWidth = 0
        Img.layer.masksToBounds = true
        Img.alpha = 0.5

        Img.translatesAutoresizingMaskIntoConstraints = false
        Img.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        Img.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        Img.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        Img.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
}
