//
//  TimeConverter.swift
//  My Stocks
//
//  Created by Dmitry on 21.11.2022.
//

import UIKit

final class TimeConverter {
    
    enum PeriodUnit: String {
        case time
        case date
    }
    
    func convertTimeStampToTimeDict(stamp: Int) -> [String:String] {
        var dict = [String:String]()
        let date = NSDate(timeIntervalSince1970: TimeInterval(stamp))
        let hourString = handleOneSignNumber(number: Calendar.current.component(.hour, from: date as Date))
        let minuteString = handleOneSignNumber(number: Calendar.current.component(.minute, from: date as Date))
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
        let someDate = Date()
        return Int(someDate.timeIntervalSince1970)
    }
    func yearBeforeDateToTimeStamp() -> Int {
        let someDate = Calendar.current.date(byAdding: .month, value: -12, to: Date())
        return Int(someDate!.timeIntervalSince1970)
    }
    // удалить
//    func convertTimeStampToTimeString(stamp: Int) -> Double {
//        let date = NSDate(timeIntervalSince1970: TimeInterval(stamp))
//        let day = handleOneSignNumber(number: Calendar.current.component(.day, from: date as Date))
//        let month = handleOneSignNumber(number: Calendar.current.component(.month, from: date as Date))
//        let dateString = "\(String(month)).\(day)"
//        return Double(dateString)!
//    }
    
    func dateInDashForman(offsetDays: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: -offsetDays, to: Date())!
        let day = handleOneSignNumber(number:Calendar.current.component(.day, from: date as Date))
        let month = handleOneSignNumber(number:Calendar.current.component(.month, from: date as Date))
        let year = Calendar.current.component(.year, from: date as Date)
        return ("\(year)-\(month)-\(day)")
    }
    
    func getCurrentMonth()->Int? {
        let todayDate = Date()
        let myCalendar = NSCalendar(calendarIdentifier: .gregorian)
        let myComponents = myCalendar?.components(.month, from: todayDate)
        let month = myComponents?.month
        return month
    }
    
}
