//
//  searchCell.swift
//  santaProject
//
//  Created by 이병훈 on 2021/06/26.
//

import UIKit

protocol SearchCellDelegate {
    func deleteButtonDidTouched(cell: searchCell)
}

class searchCell: UITableViewCell {
    var mountainLabel: UILabel!
    var accessoryImage: UIImageView!
    //2번쨰 방법
    var deleteButton: UIButton!
    let margin: CGFloat = 20
    var delegate: SearchCellDelegate?
    var idx: Int?
    
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
        mountainLabel.font = .systemFont(ofSize: 16, weight: .regular)
        mountainLabel.textColor = .stCoolGray120
        
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
        
        deleteButton.addTarget(self, action: #selector(touchDeleteButton), for: .touchUpInside)
    }
    
    @objc
    func touchDeleteButton() {
        delegate?.deleteButtonDidTouched(cell: self)
    }

    
}

class SearchResultCell: UITableViewCell {

    var mountain: Mountain? {
        didSet {
            update()
        }
    }
    
    var mountainImage = UIImageView()
    var visitImage = UIImageView()
    var mountainLabel = UILabel()
    var regionTagView = RegionTagView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        makeMountainBadge()
        makeVisitBadge()
        makeMountainLabel()
        makeRegionTagView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeMountainBadge() {
//        mountainImage = UIImageView.init()
        
        mountainImage.image = UIImage(named: "santaTabImageListInactive")
        self.contentView.addSubview(mountainImage)
        mountainImage.translatesAutoresizingMaskIntoConstraints = false
        mountainImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        mountainImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mountainImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        mountainImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        mountainImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
        mountainImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    func makeVisitBadge() {
//        visitImage = UIImageView.init()
        // 이미지 설정
        visitImage.image = UIImage(named: "santaFlagInactive")
        self.contentView.addSubview(visitImage)
        visitImage.translatesAutoresizingMaskIntoConstraints = false
//        visitImage.leadingAnchor.constraint(equalTo: ).isActive = true
        visitImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32).isActive = true
        visitImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        visitImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        visitImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
//        visitImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
        visitImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    func makeMountainLabel() {
        //register도 무조건 설정
        self.contentView.addSubview(mountainLabel)
        mountainLabel.font = UIFont.systemFont(ofSize: 13)

        mountainLabel.translatesAutoresizingMaskIntoConstraints = false
        mountainLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        mountainLabel.leadingAnchor.constraint(equalTo: visitImage.trailingAnchor, constant: 13).isActive = true
    }
    
    func makeRegionTagView() {
        self.contentView.addSubview(regionTagView)
        regionTagView.translatesAutoresizingMaskIntoConstraints = false
        //38,24
        regionTagView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        regionTagView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        regionTagView.leadingAnchor.constraint(equalTo: mountainLabel.trailingAnchor, constant: 16).isActive = true
        regionTagView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    func update() {
        var favoriteImageName = "santaTabImageListInactive"
        if let isFavorite = mountain?.isFavorite, isFavorite {
            favoriteImageName = "santaTabImageListActive"
        }
        
        var visitImageName = "santaTabImageListInactive"
        if let isVisit = mountain?.isVisit, isVisit {
            visitImageName = "santaFlagActive"
        }
        visitImage.image = UIImage(named: visitImageName)
        mountainImage.image = UIImage(named: favoriteImageName)
        regionTagView.applyRegionName(mountain?.depth1 ?? "서울특별시")
    }
    
}

