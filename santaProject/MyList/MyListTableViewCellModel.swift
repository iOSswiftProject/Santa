//
//  MyListTableViewCellModel.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/11.
//

import UIKit

class MyListTableViewCellModel: NSObject {
    let mountain: Mountain

    var mountainName: String {
        mountain.name ?? "산이름 없음"
    }

    var peakName: String {
        mountain.peak ?? ""
    }

    var regionName: String {
        mountain.depth1 ?? "지역"
    }

    var regionColor: UIColor {
        UIColor(hex: "85DC40")
    }

    var subRegionName: String {
        mountain.depth2 ?? "소지역"
    }

    var height: Double {
        mountain.height ?? 0
    }


    init(with mountain: Mountain) {
        self.mountain = mountain
    }

    func updateInfo(for view: MountainInfoBaseView) {
        let nameView = view.mountainNameView
        nameView.updateMountainNameLabelAttributedText(mountainName: mountainName, peakName: peakName)
        nameView.updateRegionTag(regionName: regionName, color: regionColor)

        view.updateSubRegion(subregionName: subRegionName)
        view.updateHeight(height)
    }

    func configure(_ cell: UITableViewCell) {}
}

class MyListTableViewHistoryCellModel: MyListTableViewCellModel {

    var timeStamp: String {
        mountain.date ?? "0000.00.00"
    }

    override func updateInfo(for view: MountainInfoBaseView) {
        super.updateInfo(for: view)
        guard let view = view as? MountainInfoHistoryView else { return }
        view.timestampView.updateText(timeStamp)
    }

    override func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? MyListTableViewHistoryCell else { return }
        let infoView = cell.infoView
        updateInfo(for: infoView)
    }
}

class MyListTableViewBookmarkCellModel: MyListTableViewCellModel {

    var isVisited: Bool {
        mountain.isVisit ?? false
    }

    var isFavorite: Bool {
        mountain.isFavorite ?? false
    }

    override func updateInfo(for view: MountainInfoBaseView) {
        super.updateInfo(for: view)
        guard let view = view as? MountainInfoBookmarkView else { return }
        view.isBookmark = isFavorite
        view.flagged = isVisited
    }

    override func configure(_ cell: UITableViewCell) {
        guard let cell = cell as? MyListTableViewBookmarkCell else { return }
        let infoView = cell.infoView
        updateInfo(for: infoView)
    }
}
