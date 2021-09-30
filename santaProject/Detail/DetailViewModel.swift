//
//  DetailViewModel.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/08/16.
//

import Foundation

class DetailViewModel {

    let mountain: Mountain
    let detailInfo: DetailInfo?

    var mountainName: String {
        mountain.name ?? "ㅇㅇ산"
    }

    var peakName: String {
        mountain.peak ?? ""
    }

    var height: Double {
        mountain.height ?? 0
    }

    var region: String {
        mountain.depth1 ?? ""
    }

    var subRegion: String {
        mountain.depth2 ?? ""
    }

    var isVisit: Bool {
        mountain.isVisit ?? false
    }

    var isFavorite: Bool {
        mountain.isFavorite ?? false
    }

    var title: String {
        mountain.title ?? "제목"
    }

    var subtitle: String {
        mountain.subtitle ?? "내용?"
    }

    init(with mountain: Mountain, detailInfo: DetailInfo?) {
        self.mountain = mountain
        self.detailInfo = detailInfo
    }

    func congifure(_ view: DetailView) {

        // TODO: 이미지 추가

        let infoView = view.mountainInfoView
        infoView.flagged = isVisit
        infoView.isBookmark = isFavorite
        infoView.mountainNameView.updateMountainNameLabelAttributedText(mountainName: mountainName, peakName: peakName)
        infoView.mountainNameView.updateRegionTag(regionName: region)
        infoView.updateSubRegion(subregionName: subRegion)
        infoView.updateHeight(height)


        // TODO: 자세한 설명 추가
        if let detailInfo = detailInfo {
            view.setupDetailInfoView(with: detailInfo)
        }
    }
}
