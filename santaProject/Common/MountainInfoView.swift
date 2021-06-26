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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMountainNameLabel()
        setupSeparatorView()
        setupRegionTagView()
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
    }
}
