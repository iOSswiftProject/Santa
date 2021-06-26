//
//  MountainInfoView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/22.
//

import UIKit

struct MockDataModel {
    var mountainName: String = "관악산"
    var peakName: String = "땡땡봉"
    var region: String = "서울"
    var subRegion: String = "관악구"
    var height: Double = 632
    var visited: Bool = false
    var isBookmark: Bool = false
}

class MountainInfoView: UIView {

    let mountainNameLabel = UILabel()
    let separatorView = UIView()
    let regionTagView = RegionTagView()
    let subRegionLabel = UILabel()
    let lowerSeparatorView = UIView()
    let heightLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMountainNameLabel()
        setupSeparatorView()
        setupRegionTagView()
        setupSubRegionLabel()
        setupLowerSeparatorView()
        setupHeightLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMountainNameLabel() {
        addSubview(mountainNameLabel)
        mountainNameLabel.translatesAutoresizingMaskIntoConstraints = false
        mountainNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.MountainNameLabel.sideMargin).isActive = true
        mountainNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.MountainNameLabel.topMargin).isActive = true
        updateMountainNameLabelAttributedText(mountainName: "관악산", peakName: "땡땡봉")
        mountainNameLabel.sizeToFit()
    }

    private func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.Separator.sideMargin).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.Separator.sideMargin).isActive = true
        separatorView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.Separator.topMargin).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: Layout.Separator.height).isActive = true
        separatorView.backgroundColor = UIColor(hex: "EEEEEE")
    }

    private func setupRegionTagView() {
        addSubview(regionTagView)
        regionTagView.translatesAutoresizingMaskIntoConstraints = false
        regionTagView.leadingAnchor.constraint(equalTo: mountainNameLabel.trailingAnchor, constant: 8).isActive = true
        regionTagView.centerYAnchor.constraint(equalTo: mountainNameLabel.centerYAnchor).isActive = true
        regionTagView.heightAnchor.constraint(equalToConstant: Layout.RegionTag.height).isActive = true
        updateRegionTag(regionName: "서울", color: UIColor(hex: "#85DC40"))
    }

    private func setupSubRegionLabel() {
        addSubview(subRegionLabel)
        subRegionLabel.translatesAutoresizingMaskIntoConstraints = false
        subRegionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.SubRegionLabel.sideMargin).isActive = true
        subRegionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.SubRegionLabel.bottomMargin).isActive = true

        subRegionLabel.font = .systemFont(ofSize: Layout.LowerPart.fontSize)
        subRegionLabel.textColor = Layout.LowerPart.textColor
        updateSubRegion(subregionName: "관악구")
    }

    private func setupLowerSeparatorView() {
        addSubview(lowerSeparatorView)
        lowerSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        lowerSeparatorView.leadingAnchor.constraint(equalTo: subRegionLabel.trailingAnchor, constant: Layout.LowerSeparator.margin).isActive = true
        lowerSeparatorView.centerYAnchor.constraint(equalTo: subRegionLabel.centerYAnchor).isActive = true
        lowerSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        lowerSeparatorView.heightAnchor.constraint(equalToConstant: Layout.LowerSeparator.height).isActive = true
        lowerSeparatorView.backgroundColor = UIColor(hex: "EEEEEE")
    }

    private func setupHeightLabel() {
        addSubview(heightLabel)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.leadingAnchor.constraint(equalTo: lowerSeparatorView.trailingAnchor, constant: Layout.LowerSeparator.margin).isActive = true
        heightLabel.centerYAnchor.constraint(equalTo: subRegionLabel.centerYAnchor).isActive = true

        heightLabel.font = .systemFont(ofSize: Layout.LowerPart.fontSize)
        heightLabel.textColor = Layout.LowerPart.textColor
        updateHeight(632)
    }
}

extension MountainInfoView {
    private func updateMountainNameLabelAttributedText(mountainName: String, peakName: String?) {
        let text = mountainName + " " + (peakName ?? "")
        let textAsNSString = text as NSString
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.font,
                                      value: Layout.MountainNameLabel.mountainFont,
                                      range: textAsNSString.range(of: mountainName))
        attributedString.addAttribute(.font,
                                      value: Layout.MountainNameLabel.peakFont,
                                      range: textAsNSString.range(of: peakName ?? ""))
        mountainNameLabel.attributedText = attributedString
    }

    private func updateRegionTag(regionName: String, color: UIColor) {
        regionTagView.applyRegionName(regionName, color: color)
    }

    private func updateSubRegion(subregionName: String) {
        subRegionLabel.text = subregionName
    }

    private func updateHeight(_ height: Double) {
        let heightText = "높이 \(Int(height))m"
        heightLabel.text = heightText
    }
}

extension MountainInfoView {
    private enum Layout {
        enum MountainNameLabel {
            static let sideMargin: CGFloat = 24
            static let topMargin: CGFloat = 17
            static let fontSize: CGFloat = 20
            static let mountainFont = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(0.4))
            static let peakFont = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(0.2))
        }
        enum Separator {
            static let sideMargin: CGFloat = 20
            static let topMargin: CGFloat = 54
            static let height: CGFloat = 1
        }
        enum RegionTag {
            static let height: CGFloat = 24
        }
        enum LowerPart {
            static let fontSize: CGFloat = 12
            static let textColor = UIColor(hex: "B9B3B2")
        }
        enum SubRegionLabel {
            static let sideMargin: CGFloat = 24
            static let bottomMargin: CGFloat = 15
        }
        enum LowerSeparator {
            static let margin: CGFloat = 4
            static let height = LowerPart.fontSize
        }
    }
}
