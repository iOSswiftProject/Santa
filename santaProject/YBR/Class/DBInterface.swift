//
//  DBInterface.swift
//  santaProject
//
//  Created by yeongbinRo on 2021/06/23.
//

import Foundation
import SQLite3

// apply Singleton
class DBInterface: NSObject {
    
    static let shared = DBInterface()
    var db: OpaquePointer?
    
    override init() {
        super.init()
        copyDatabase()
        
        let documentDirecotry = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let databasePath = documentDirecotry?.appendingPathComponent("Santa.db")
        
        if let dbpath = databasePath?.path {
            sqlite3_open(dbpath, &db)
        }
        
    }

    func copyDatabase() {
        
        let fileManger = FileManager.default
        
        guard let documentsUrl = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let finalDatabaseURL = documentsUrl.appendingPathComponent("Santa.db")
        
        do {
            if !fileManger.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                
                if let dbFilePath = Bundle.main.path(forResource: "Santa", ofType: "db") {
                    try fileManger.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                    print("copy success")
                } else {
                    print("Santa.db doesn't exist in the app bundle")
                }
                
            } else {
                print("DB already exist")
            }
        } catch {
            print("Unable to copy Santa.db\(error)")
        }
        
    }
    
    
    /// select Mountain From MOUNTAIN TABLE with depth1 & depth2
    func selectMountain(depth1: String, depth2: String) -> [Mountain]{
        var res:[Mountain] = []
        
        var queryStatment: OpaquePointer? = nil
        let query = String(format: "SELECT NAME, HEIGHT, LATITUDE, LONGTITUDE, DEPTH1, DEPTH2, PEAK, ISFAVORITE, ISVISIT, ID  FROM MOUNTAIN where DEPTH1='%@' AND DEPTH2='%@'", depth1, depth2)
        if sqlite3_prepare_v2(DBInterface.shared.db, query, -1, &queryStatment, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatment) == SQLITE_ROW {
                
                let queryResultCol0 = sqlite3_column_text(queryStatment, 0)
                let name = String(cString: queryResultCol0!)
                
                let height = sqlite3_column_double(queryStatment, 1)
                let latitude = sqlite3_column_double(queryStatment, 2)
                let longtitude = sqlite3_column_double(queryStatment, 3)
                
                let queryResultCol4 = sqlite3_column_text(queryStatment, 4)
                let depth1 = String(cString: queryResultCol4!)
                let queryResultCol5 = sqlite3_column_text(queryStatment, 5)
                let depth2 = String(cString: queryResultCol5!)
                
                var peak = ""
                if let queryResultCol6 = sqlite3_column_text(queryStatment, 6) {
                    peak = String(cString: queryResultCol6)
                }
                
                
                let isFavorite = sqlite3_column_int(queryStatment, 7)
                let isVisit = sqlite3_column_int(queryStatment, 8)
                let id = sqlite3_column_int(queryStatment, 9)
                
                let mountain = Mountain.init(name: name, peak: peak, height: height, depth1: depth1, depth2: depth2, latitude: latitude, longtitude: longtitude, id: id, isFavorite: isFavorite, isVisit: isVisit)
                        
                res.append(mountain)
            }
            
        }

        return res
    }
    
    /// select  favorite Mountain From MOUNTAIN TABLE
    func seletMountainFavorite() {
        var queryStatment: OpaquePointer? = nil
        let query = String(format: "SELECT NAME, HEIGHT, LATITUDE, LONGTITUDE, DEPTH1, DEPTH2 FROM MOUNTAIN where ISFAVOIRTE=%@", 1)
        
        if sqlite3_prepare_v2(DBInterface.shared.db, query, -1, &queryStatment, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatment) == SQLITE_ROW {
                
                let queryResultCol0 = sqlite3_column_text(queryStatment, 0)
                let name = String(cString: queryResultCol0!)
                
                print("select favoirte mountain",name)
            }
            
        }
        
    }
    
    /// select Mountain From LOG TABLE
    func selectMountainLog() {
        /**
         * briefly use join, late use paing
         */
    }
    
    
    /// insert Log data to LOG TABLE with mountainId & Date("YYYY-MM-DD HH:MM:SS")
    func insertLOG(mountainId: Int, date:String) {
        
        let insertStatementString = "INSERT INTO LOG (MOUNTAINID, DATE VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {

            sqlite3_bind_int(insertStatement, 1, Int32(mountainId))
            sqlite3_bind_text(insertStatement, 2, (date as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("inserted row successfully")
            } else {
                print("couldn't insert row")
            }
            
        } else{
            print("INSERT stateent could not be prepared.")
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print("Quert could not be prepared! \(errorMessage)")
        }
        
        
    }
    
    
}
