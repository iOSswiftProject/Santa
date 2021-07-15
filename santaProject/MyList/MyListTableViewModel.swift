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
        loadHistory()
        createCellModels()
    }

    func cellModel(for indexPath: IndexPath) -> MyListTableViewCellModel? {
        guard indexPath.row < count else { return nil }
        return cellModels[indexPath.section]
    }

    private func loadHistory() {
        var result = DBInterface.shared.selectMountainLog()
        result = result.sorted(by: {
            let date1 = $0.date ?? "0000.00.00"
            let date2 = $1.date ?? "0000.00.00"
            return date1 > date2
        })
        history = result
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
