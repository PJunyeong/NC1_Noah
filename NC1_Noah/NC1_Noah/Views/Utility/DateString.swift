//
//  DateString.swift
//  NC1_Noah
//
//  Created by Junyeong Park on 2022/05/05.
//

import Foundation

func DateToString(date:Date)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateString = dateFormatter.string(from:date)
    return dateString
}

func StringToDate(dateString:String)->Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dateFormatter.date(from: dateString)!
    return date
}

extension Date{
    var relativeTime_abbreviated:String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
