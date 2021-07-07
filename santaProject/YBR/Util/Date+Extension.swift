//
//  Date+Extension.swift
//  santaProject
//
//  Created by yeongbinro on 2021/07/07.
//

import Foundation

extension Date {
    
    /// NSDate의 날짜를 NSString 날짜 포맷으로 변환
    public func dateToString(format: String = "yyyy-MM-dd HH:mm:SS", localIdentifier: String = "ko_kr") -> String {
        return self.dateToString(format: format, localeIdentifier: localIdentifier)
    }
    
    
    /// NSDate의 일자를 NSString 날짜 포맷으로 변환
    public func dateToString(format: String, localeIdentifier: String?) -> String {
        let dateFmt = format
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFmt
        if localeIdentifier != nil && localeIdentifier != "" {
            dateFormatter.locale = Locale(identifier: localeIdentifier ?? "")
        }
        let stringFromDate = dateFormatter.string(from: self)
        
        return stringFromDate
        
    }
    
    
    func changeDateFormat(dateStr:String) -> String{
        
//        let dateStr = "yyyy-MM-dd HH:MM:SS"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        
        let conrtDate = dateFormatter.date(from: dateStr)
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd"
        
        // locale..?
//        myDateFormatter.locale = Locale(identifier: "ko_KR")
        let converStr = myDateFormatter.string(from: conrtDate!)
        return converStr
    }
    

    
}
