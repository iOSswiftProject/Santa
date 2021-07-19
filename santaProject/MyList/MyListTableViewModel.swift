//
//  MyListHistoryViewModel.swift
//  santaProject
//
//  Created by Juwon Kim on 2021/07/11.
//

import Foundation

protocol MyListTableViewModel: AnyObject {
    var count: Int { get }

    func cellModel(for indexPath: IndexPath) -> MyListTableViewCellModel?
}

class MyListHistoryTableViewModel: MyListTableViewModel {

    var history: [Mountain] = []
    var cellModels: [MyListTableViewHistoryCellModel] = []

    var count: Int {
        history.count
    }

    init() {
        history = DBInterface.shared.selectMountainLog()
        sortHistory()
        createCellModels()
    }

    func cellModel(for indexPath: IndexPath) -> MyListTableViewCellModel? {
        guard indexPath.row < count else { return nil }
        return cellModels[indexPath.section]
    }

    func addHistory(mountain: Mountain, date: String) {
        mountain.date = date
        var index: Int = 0
        for idx in 0..<history.count {
            if let historyDate = history[idx].date, historyDate < date {
                index = idx
                break
            }
        }
        history.insert(mountain, at: index)
        let cellModel = MyListTableViewHistoryCellModel(with: mountain)
        cellModels.insert(cellModel, at: index)
    }

    private func sortHistory() {
        history = history.sorted(by: {
            let date1 = $0.date ?? "0000.00.00"
            let date2 = $1.date ?? "0000.00.00"
            return date1 > date2
        })
    }

    private func createCellModels() {
        let cellModels = history.map {
            return MyListTableViewHistoryCellModel(with: $0)
        }
        self.cellModels = cellModels
    }
}

class MyListFavoriteTableViewModel: MyListTableViewModel {

    var bookmarks: [Mountain] = []
    var cellModels: [MyListTableViewBookmarkCellModel] = []

    var count: Int {
        bookmarks.count
    }

    init() {
        loadFavorite()
        bookmarkSomeMountainsIfNeeded()
        createCellModels()
    }

    func cellModel(for indexPath: IndexPath) -> MyListTableViewCellModel? {
        guard indexPath.row < count else { return nil }
        return cellModels[indexPath.section]
    }

    func updateVisited(id: Int) {
        bookmarks.forEach {
            if let mountainId = $0.id, mountainId == id {
                $0.isVisit = true
            }
        }
        cellModels.forEach {
            if let mountainId = $0.mountain.id, mountainId == id {
                $0.mountain.isVisit = true
            }
        }
    }

    private func loadFavorite() {
        let result = DBInterface.shared.seletMountainFavorite()
        bookmarks = result
    }

    private func createCellModels() {
        let cellModels = bookmarks.map { MyListTableViewBookmarkCellModel(with: $0) }
        self.cellModels = cellModels
    }

    // Need to remove
    private func bookmarkSomeMountainsIfNeeded() {
        guard bookmarks.isEmpty else { return }
        print("bookmark empty! check 1,3 as favorite")
        let allMountains = DBInterface.shared.selectMountain()
        var ids: [Int32] = []
        ids.append(allMountains[1].id ?? -1)
        ids.append(allMountains[3].id ?? -1)
        ids.forEach {
            DBInterface.shared.updateIsFavorite(mountainId: $0, isFavorite: true)
        }

        DBInterface.shared.updateIsVisit(mountainId: 1, isVisit: true)

        loadFavorite()
    }
}
