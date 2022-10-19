//
//  SearchCell.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    var delegate: AddTickerToStockListProtocol?
    var showAlertDelegate: ShowAlertProtocol?
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var stockTypeLabel: UILabel!
    
    private var symbol = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupSearchCell(stock: Stocks) {
        companyLabel.text = stock.description
        tickerLabel.text = stock.symbol
        symbol = stock.symbol
        if stock.type == "" {
            stockTypeLabel.text = "Type not available"
        } else {
        stockTypeLabel.text = stock.type
        }
    }


    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if checkSymbol(symbol: symbol) {
            print("Contain dots ->> ", symbol)
            showAlertDelegate?.showAlert()
            
        } else {
            delegate?.getTickerFromSearchScreen(ticker: symbol)
            sender.isHidden = true
        }
    }
}

    
    func checkSymbol(symbol: String) -> Bool {
        var array = [""]
        for i in symbol {
            array.append(String(i))
        }
        if array.contains(where: {$0 == "."}) {
            return true
        } else {
            return false
        }
        
    }

