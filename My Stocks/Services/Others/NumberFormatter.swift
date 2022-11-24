//
//  NumberFormatter.swift
//  My Stocks
//
//  Created by Dmitry on 23.11.2022.
//

import UIKit
import Charts

final class MonthNumberFormatter: NSObject, AxisValueFormatter {

    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    private var startMonthIndex:Int!


    convenience init(startMonthIndex: Int){
        self.init()
        self.startMonthIndex = startMonthIndex

    }

    private func getMonth(index: Int) -> Int{
        return (index % months.count)
    }
    
    // тут пока костыль
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        // print(value)
        //let monthIndex:Int = self.getMonth(index: Int(value) + self.startMonthIndex)
        //let month = months[monthIndex]
        let data = [0:"Nov",20:"Dec",40:"Jan",60:"Feb",80:"Mar",100:"Apr",120:"May",140:"Jun",160:"Jul",180:"Aug",200:"Sep",220:"Oct",240:"Nov"]
        return data[Int(value)]!
        
        
    }
}
