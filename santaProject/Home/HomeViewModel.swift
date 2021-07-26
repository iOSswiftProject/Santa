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

    init(with mountain: Mountain) {
        self.mountain = mountain
    }
}

class HomeViewModel: NSObject {

    var history: [Mountain] = []
    var historyCellModels: [HomeViewHistoryCellModel] = []
    var accumulateHeight: Int = 0

    func cellImage(for index: Int) -> UIImage? {
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

        print("index: \(index), name: \(imageName(for: index))")
        return UIImage(named: imageName(for: index))
    }

    public func update() {
        loadHistory()
        makeHistoryModel()
        calculateAccumulateHeight()

        for idx in 0...history.count {
            _ = cellImage(for: idx)
        }
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
        historyCellModels = history.map{ HomeViewHistoryCellModel(with: $0) }
    }

    private func calculateAccumulateHeight() {
        var accumulateHeight: Double = 0
        history.forEach { accumulateHeight += $0.height ?? 0 }
        self.accumulateHeight = Int(accumulateHeight)
    }
}
