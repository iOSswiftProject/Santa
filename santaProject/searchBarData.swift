//
//  searchBarData.swift
//  santaProject
//
//  Created by 이병훈 on 2021/05/31.
//

import UIKit

class searchBarData {
//    var searchItems: [String] = []
//    let localItems: [String] = ["설악산","지리산","무등산","아무산","그냥산","앞산","뒷산","그산","오른쪽산"]

    var searchItems: [String] = []{
        
        didSet {
            if searchItems.count == 0 {
                return
            }
            //1. 중복체크. 기존에 존재 시 제거.
            let latesName = searchItems.last
            for i in 0..<searchItems.count-1 {
                if latesName == searchItems[i] {
                    searchItems.remove(at: i)
                }
            }
            
            // 10개로 용량제한
            if searchItems.count > 10 {
                searchItems.removeFirst()
            }
            
        }
        
    }

    let localItems: [String] = {
        var mountainArr = [String]()
        let mountains = DBInterface.shared.selectMountain()
        for mountain in mountains {
            var str = ""
    
            if let name = mountain.name {
                str.append(name)
            }
            if let peak = mountain.peak {
                str.append(String(format: " %@", peak))
            }
            
            if str != "" {
                mountainArr.append(str)
            }
            
        }
        return mountainArr
    }()
    
    let mountainItems:[Mountain] = {
        return DBInterface.shared.selectMountain()
    }()
    
    var filterValue: [String] = []
    var filteredValue: [Mountain] = []
}

