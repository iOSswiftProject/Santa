//
//  MountainNameView.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/06/27.
//

import UIKit

class MountainNameView: UIView {

    let mountainNameLabel = UILabel()

    let regionTagView = RegionTagView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMountainNameLabel()
        setupRegionTagView()

        updateMountainNameLabelAttributedText(mountainName: "관악산", peakName: "땡땡봉")
        updateRegionTag(regionName: "서울", color: UIColor(hex: "#85DC40"))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMountainNameLabel() {
        addSubview(mountainNameLabel)
        mountainNameLabel.translatesAutoresizingMaskIntoConstraints = false
        mountainNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mountainNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    private func setupRegionTagView() {
        addSubview(regionTagView)
        regionTagView.translatesAutoresizingMaskIntoConstraints = false
        regionTagView.leadingAnchor.constraint(equalTo: mountainNameLabel.trailingAnchor, constant: Layout.spacing).isActive = true
        regionTagView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        regionTagView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        regionTagView.heightAnchor.constraint(equalToConstant: Layout.RegionTag.height).isActive = true
    }

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
}

extension MountainNameView {
    private enum Layout {
        static let spacing: CGFloat = 8
        
        enum MountainNameLabel {
            static let sideMargin: CGFloat = 24
            static let topMargin: CGFloat = 17
            static let fontSize: CGFloat = 20
            static let mountainFont = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(0.4))
            static let peakFont = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(0.2))
        }
        enum RegionTag {
            static let height: CGFloat = 24
        }
    }
}
