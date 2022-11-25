//
//  StockCell.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class StockCell: UITableViewCell {
    
    private var stockImageHandler = StockDetailsLoader()
    var ticker = String()
    var favoriteStocksArray = [String]()
    let defaults = UserDefaults.standard
    private var dataStorageManager = DataStorageManager()
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.layer.cornerRadius = backgroundImage.frame.height/3
        backgroundImage.clipsToBounds = true
        
    }
    
    func setupCell(stockModel: StockModel,logo: UIImage, stockDetails: StockDetailsModel?) {
        logoImage.image = logo
        companyName.text = stockDetails?.name
        stockLabel.text = stockModel.stockName
        currentPriceLabel.text = "$" + String(format: "%.1f", stockModel.currentPrice)
        if stockModel.percentChange > 0 {
            priceChangeLabel.text = "+" + String(format: "%.2f", stockModel.percentChange) + " %"
            priceChangeLabel.textColor = UIColor(hexString: "24B35D")
        } else {
            priceChangeLabel.text = String(format: "%.2f", stockModel.percentChange) + " %"
            priceChangeLabel.textColor = UIColor(hexString: "FB2916")
        }
    }
}


