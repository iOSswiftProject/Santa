//
//  RegionTagView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/26.
//

import UIKit

class RegionTagView: UIView {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = Layout.cornerRadius
        layer.borderWidth = Layout.borderWidth
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.sideMargin).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: Layout.topMargin).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.topMargin).isActive = true

        label.font = .boldSystemFont(ofSize: Layout.fontSize)
        label.text = "서울"
    }

    func applyRegionName(_ name: String) {
        let info = RegionTagInfo(name)
        label.text = info.title
        label.textColor = info.color
        layer.borderColor = info.color.cgColor
    }

    func applyRegionName(_ name: String, color: UIColor) {
        label.text = name
        label.textColor = color
        layer.borderColor = color.cgColor
    }
}

extension RegionTagView {
    enum Layout {
        static let sideMargin: CGFloat = 8
        static let topMargin: CGFloat = 6
        static let fontSize: CGFloat = 12
        static let cornerRadius: CGFloat = 12
        static let borderWidth: CGFloat = 1.2
    }
}

struct RegionTagInfo {

    let title: String
    let color: UIColor

    init(_ regionName: String) {
        let (title, color) = RegionTagInfo.info(for: regionName)
        self.title = title
        self.color = color
    }

    static func info(for regionName: String) -> (title: String, color: UIColor) {
        switch regionName {
        case "서울특별시":
            return ("서울", UIColor(hex: "FF8139"))
        case "인천광역시":
            return ("인천", UIColor(hex: "666666"))
        case "대전광역시":
            return ("대전", UIColor(hex: "3785C1"))
        case "광주광역시":
            return ("광주", UIColor(hex: "1FBCD3"))
        case "대구광역시":
            return ("대구", UIColor(hex: "77CF2F"))
        case "부산광역시":
            return ("부산", UIColor(hex: "5FB7FF"))
        case "울산광역시":
            return ("울산", UIColor(hex: "617D8A"))
        case "세종특별자치시":
            return ("세종", UIColor(hex: "EA447B"))
        case "제주특별자치도":
            return ("제주", UIColor(hex: "FFA51E"))
        case "경기도":
            return ("경기", UIColor(hex: "A38D72"))
        case "강원도":
            return ("강원", UIColor(hex: "25B573"))
        case "충청북도":
            return ("충북", UIColor(hex: "16998E"))
        case "충청남도":
            return ("충남", UIColor(hex: "CC50CA"))
        case "전라북도":
            return ("전북", UIColor(hex: "EC5D5C"))
        case "전라남도":
            return ("전남", UIColor(hex: "9D88C6"))
        case "경상북도":
            return ("경북", UIColor(hex: "8D68CF"))
        case "경상남도":
            return ("경남", UIColor(hex: "785549"))
        default:
            fatalError("Wrong region name: \(regionName)")
        }
    }
}
