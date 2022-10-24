//
//  StockCell.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class StockCell: UITableViewCell {
    
    var ticker = String()
    var favoriteStocksArray = [String]()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.layer.cornerRadius = backgroundImage.frame.height/3
        backgroundImage.clipsToBounds = true
        
    }

    @IBAction func addToFavoriteButtonTapped(_ sender: UIButton) {
        
        if sender.tintColor == .systemYellow {
            favoriteButton.tintColor = .systemGray
            removeStockFromStorage(ticker: ticker, key: "favorite")
        } else {
            addStockToStorage(ticker: ticker, key: "favorite")
            favoriteButton.tintColor = .systemYellow
        }
        
    }
    
    func setupCell(stockModel: StockModel) {
        setupAddToFavoriteButton()
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
    
//    func addStockToFavorites() {
//        let userDefaults = UserDefaults.standard
//        if var array = userDefaults.stringArray(forKey: "favorite") {
//            array.append(ticker)
//            userDefaults.set(array, forKey: "favorite")
//            print(userDefaults.stringArray(forKey: "favorite")!)
//        } else {
//            var array = [String]()
//            array.append(ticker)
//            userDefaults.set(array, forKey: "favorite")
//            print(userDefaults.stringArray(forKey: "favorite")!)
//        }
//        
//    }
//    func removeStockFromFavorites() {
//        let userDefaults = UserDefaults.standard
//        var array = userDefaults.stringArray(forKey: "favorite")!
//        if let index = array.firstIndex(of: ticker) {
//            array.remove(at: index)
//        }
//        userDefaults.set(array, forKey: "favorite")
//        print(userDefaults.stringArray(forKey: "favorite")!)
//    }
    
    func setupAddToFavoriteButton() {
        let userDefaults = UserDefaults.standard
        if let favoriteStocksArray = userDefaults.stringArray(forKey: "favorite") {
            if favoriteStocksArray.contains(where: {$0 == ticker}) {
                favoriteButton.tintColor = .systemYellow
            } else {
                favoriteButton.tintColor = .systemGray
            }
        }
    }
    
}


