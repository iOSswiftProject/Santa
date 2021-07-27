//
//  HomeViewModel.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/26.
//

import Foundation
import UIKit

class HomeViewHistoryCellModel: NSObject {
    var mountain: Mountain

    var dateString: String {
        mountain.date ?? "00.00.00"
    }

    var nameString: String {
        let mountainName = mountain.name ?? "땡땡산"
        let peakName = mountain.peak ?? ""
        return "\(mountainName) \(peakName)"
    }

    var mountainImage: UIImage?

    init(with mountain: Mountain, image: UIImage?) {
        self.mountain = mountain
        self.mountainImage = image
    }

    func configure(cell: HomeViewTableViewCell) {
        cell.dateLabel.attributedText = attrDate()
        cell.nameLabel.attributedText = attrName()
        cell.mountainImageView.image = mountainImage
    }

    func attrDate() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: dateString)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: -0.04, range: range)
        return attrString
    }

    func attrName() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: nameString)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.kern, value: -0.08, range: range)
        return attrString
    }
}

class HomeViewModel: NSObject {

    var history: [Mountain] = []
    var historyCellModels: [HomeViewHistoryCellModel] = []
    var accumulateHeight: Int = 0

    private func cellImage(for index: Int) -> UIImage? {
        func imageName(for index: Int) -> String {
            let imagePrefix = "home_illust_"
            var imagePostfix = ""
            if index < 3 {
                imagePostfix = String(index + 1)
            }
            else {
                let repeatCount = 12
                let remain = (index - 3) % repeatCount
                imagePostfix = String(remain + 4)
            }
            return imagePrefix + imagePostfix
        }
        return UIImage(named: imageName(for: index))
    }

    public func update() {
        loadHistory()
        makeHistoryModel()
        calculateAccumulateHeight()
    }

    private func loadHistory() {
        let unsortedHistory = DBInterface.shared.selectMountainLog()
        history = unsortedHistory.sorted {
            let date1 = $0.date ?? "0000.00.00"
            let date2 = $1.date ?? "0000.00.00"
            return date1 > date2
        }
    }

    private func makeHistoryModel() {
        for (idx, mountain) in history.enumerated() {
            let image = cellImage(for: idx)
            let model = HomeViewHistoryCellModel(with: mountain, image: image)
            historyCellModels.append(model)
        }
    }

    private func calculateAccumulateHeight() {
        var accumulateHeight: Double = 0
        history.forEach { accumulateHeight += $0.height ?? 0 }
        self.accumulateHeight = Int(accumulateHeight)
    }
}
