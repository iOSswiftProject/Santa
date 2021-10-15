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

    func removeHistory(at index: Int) {
        guard index < history.count else { fatalError("Index error! history count: \(history.count), index: \(index)") }
        history.remove(at: index)
        cellModels.remove(at: index)
    }

    func countFor(id: Int32) -> Int {
        history.filter{ $0.id == id }.count
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
        createCellModels()
    }

    func cellModel(for indexPath: IndexPath) -> MyListTableViewCellModel? {
        guard indexPath.row < count else { return nil }
        return cellModels[indexPath.section]
    }

    func updateVisited(id: Int, visited: Bool) {
        bookmarks.forEach {
            if let mountainId = $0.id, mountainId == id {
                $0.isVisit = visited
            }
        }
        cellModels.forEach {
            if let mountainId = $0.mountain.id, mountainId == id {
                $0.mountain.isVisit = visited
            }
        }
    }

    func removeBookmark(at index: Int) {
        guard index < bookmarks.count else { fatalError("Index error! bookmark count: \(bookmarks.count), index: \(index)") }
        bookmarks.remove(at: index)
        cellModels.remove(at: index)
    }

    private func loadFavorite() {
        let result = DBInterface.shared.seletMountainFavorite()
        bookmarks = result
    }

    private func createCellModels() {
        let cellModels = bookmarks.map { MyListTableViewBookmarkCellModel(with: $0) }
        self.cellModels = cellModels
    }
}
