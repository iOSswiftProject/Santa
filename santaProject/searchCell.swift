//
//  searchCell.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/26.
//

import UIKit

class searchCell: UITableViewCell {
    var mountainLabel: UILabel!
    var accessoryImage: UIImageView!
    //2번쨰 방법
    var deleteButton: UIButton!
    let margin: CGFloat = 20
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeMountainLabel()
//        makeAccessoryImage()
        makeButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeMountainLabel() {
        mountainLabel = UILabel()
        //register도 무조건 설정
        self.contentView.addSubview(mountainLabel)
        mountainLabel.font = UIFont.systemFont(ofSize: 13)
        
        mountainLabel.translatesAutoresizingMaskIntoConstraints = false
        mountainLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: margin).isActive = true
        mountainLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: margin).isActive = true
    }
    func makeAccessoryImage() {
        accessoryImage = UIImageView()
        let image = UIImage(named: "next")
        accessoryImage.image = image
        
        self.contentView.addSubview(accessoryImage)
        
        accessoryImage.isUserInteractionEnabled = true
        accessoryImage.translatesAutoresizingMaskIntoConstraints = false
        accessoryImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -margin).isActive = true
        accessoryImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: margin).isActive = true
    }
    func makeButton() {
        deleteButton = UIButton()
        let image = UIImage(named: "delete")
        deleteButton.setImage(image, for: .normal)
        
        self.contentView.addSubview(deleteButton)
        deleteButton.isUserInteractionEnabled = true
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -margin).isActive = true
        deleteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: margin).isActive = true
    }

    
}
