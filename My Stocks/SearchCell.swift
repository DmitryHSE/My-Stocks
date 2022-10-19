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
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var stockTypeLabel: UILabel!
    
    private var symbol = ""
    var arrayWithAddedStocks = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupSearchCell(stock: StockForSearchCell) {
        companyLabel.text = stock.name
        tickerLabel.text = stock.ticker
        symbol = stock.ticker
        if stock.type == "" {
            stockTypeLabel.text = "Type not available"
        } else {
        stockTypeLabel.text = stock.type
        }
    }


    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if arrayWithAddedStocks.contains(where: {$0 == symbol}) {
            print("Array alreade contains ", symbol)
            showAlertDelegate?.showAlert(message: "Tiker already in the list")
        } else {
            if checkSymbol(symbol: symbol) {
                print("Contain dots ->> ", symbol)
                showAlertDelegate?.showAlert(message: "Invalid ticker")
                
            } else {
                delegate?.getTickerFromSearchScreen(ticker: symbol)
                addButton.isHidden = true
            }
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

