//
//  RegionInfo.swift
//  MapSample
//
//  Created by yeongbinro on 2021/06/17.
//

import Foundation


class RegionInfo {
    
    var locInfo:[String:Any]!
    
    init(resource:String, offType:String) {
        locInfo = loadJsonFile(resource: resource, offType: offType)
    }
    
    
    /// Load json
    func loadJsonFile(resource: String, offType: String) -> [String: Any] {
        
        do{
            let filePath = Bundle.main.path(forResource: resource, ofType: offType)
            
            let content = try String(contentsOfFile: filePath!)
            //            print(content)
            var ans: [String:Any] = [:]
            
            if let data = content.data(using: .utf8) {
                let outerDict = try JSONSerialization.jsonObject(with: data, options: [] ) as? [String:Any] ?? [:]
                
                //                print(outerDict)
                for depth1 in outerDict.keys {
                    //                    print(depth1)
                    
                    var newInnerDict:[String:Any] = [:]
                    
                    if let innerDict = outerDict[depth1] as? [String:Any] {
                        
                        for depth2 in innerDict.keys {
                            //                            print(depth2)
                            //                            print(innerDict[depth2])
                            if let loc = innerDict[depth2] as? [Double] {
                                let lat = loc[0]
                                let long = loc[1]
                                newInnerDict[depth2] = [lat,long]
                            } else {
                                newInnerDict[depth2] = [0.0,0.0]
                            }
                            
                        }
                        
                    }
                    
                    ans[depth1] = newInnerDict
                }
                
                
            }
            
            
            return ans
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
    
    /**
    지역정보를통해 [위도(lat),경도(long] 값을 얻어옴
     
     - Parameters:
        - depth1: 시/도
        - depth2: 시/군/구
     
     - Returns: [latiude, longtitude]
     
     */
    func getLocation(depth1: String, depth2: String) ->[Double] {
        
        
        if let innerDict = locInfo[depth1] as? [String:Any], let arr = innerDict[depth2] as? [Double]{
            
            return [arr[0], arr[1]]
        }
        
        
        return [0.0, 0.0]
    }
    
    

    ///  Depth1 주소 Array를 가져온다
    func getDepth1Arr() -> [String] {
        
        return ["서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도"]
    }
    
    
    /**
     Depth1 주소값을 통해 Depth2 주소 array를 받아온다 (가나다순 정렬)
     
     - Parameters:
        - depth1:시/군

     */
    func getDepth2Arr(depth1: String) -> [String] {

        if let innerDict = locInfo[depth1] as? [String:Any] {
            return Array(innerDict.keys).sorted(by: {$0 < $1})
        }
        
        return []
    }
    

}
