//
//  TimeConverter.swift
//  My Stocks
//
//  Created by Dmitry on 21.11.2022.
//

import UIKit

class TimeConverter {
    
    func convertTimeStampToTimeString(stamp: Int) -> [String:String] {
        var dict = [String:String]()
        let date = NSDate(timeIntervalSince1970: TimeInterval(stamp))
        let hourString = handleOneSignNumber(number: Calendar.current.component(.hour, from: date as Date)) // Calendar.current.component(.hour, from: date as Date)
        let minuteString = handleOneSignNumber(number: Calendar.current.component(.minute, from: date as Date)) //Calendar.current.component(.minute, from: date as Date)
        let timeString = "\(hourString):\(minuteString)"
        dict["time"] = timeString
        let day = Calendar.current.component(.day, from: date as Date)
        let monthInt = Calendar.current.component(.month, from: date as Date)
        let monthString = monthToString(month: monthInt)
        let dateString = "\(String(day)) \(monthString)"
        dict["date"] = dateString
        return dict
    }

    private func monthToString(month: Int) -> String {
        switch month {
        case 1:
            return "Jan."
        case 2:
            return "Feb."
        case 3:
            return "Mar."
        case 4:
            return "Apr."
        case 5:
            return "May"
        case 6:
            return "Jun."
        case 7:
            return "Jul."
        case 8:
            return "Aug."
        case 9:
            return "Sep."
        case 10:
            return "Oct."
        case 11:
            return "Nov."
        case 12:
            return "Dec."
        default:
            return ""
        }
    }
    
    private func handleOneSignNumber(number: Int) -> String {
        if number > 9 {
            return String(number)
        } else {
            return "0\(String(number))"
        }
    }
    
    func currentDateToTimeStamp() -> Int {
        // current date and time
        let someDate = Date()

        // time interval since 1970
        return Int(someDate.timeIntervalSince1970)
    }
    func yearBeforeDateToTimeStamp() -> Int {
        // current date and time
        let someDate = Calendar.current.date(byAdding: .month, value: -12, to: Date())

        // time interval since 1970
        return Int(someDate!.timeIntervalSince1970)
    }
    
    func convertTimeStampToTimeString(stamp: Int) -> Double {
        let date = NSDate(timeIntervalSince1970: TimeInterval(stamp))
        let day = handleOneSignNumber(number: Calendar.current.component(.day, from: date as Date))
        let month = handleOneSignNumber(number: Calendar.current.component(.month, from: date as Date))
        let dateString = "\(String(month)).\(day)"
        return Double(dateString)!
    }
    
}
