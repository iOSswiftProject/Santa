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

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
