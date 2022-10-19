//
//  StockDetailsVC.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import UIKit

class StockDetailsVC: UIViewController {
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    private let stockDetailManager = StockDetailManager()
    var ticker = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStockDetails()
    }
    
    private func setupVC(stockDetails: StockDetailsModel) {
        industryLabel.text = stockDetails.finnhubIndustry
        companyNameLabel.text = stockDetails.name
        currencyLabel.text = stockDetails.currency
        countryLabel.text = stockDetails.country
        marketCapLabel.text = "$"+String(format: "%.0f", (stockDetails.marketCapitalization/1000))+" mln"
        
    }
    
    private func getStockDetails() {
        stockDetailManager.performRequest(stockName: ticker) { stockDetails in
            guard let stock = stockDetails else {return}
            DispatchQueue.main.async {
                self.setupVC(stockDetails: stock)
            }
        }
    }
}
