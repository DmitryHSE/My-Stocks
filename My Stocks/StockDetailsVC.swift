//
//  StockDetailsVC.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import UIKit
import SVGKit

class StockDetailsVC: UIViewController {
    
    
    @IBOutlet weak var marketCapStaticLabel: UILabel!
    @IBOutlet weak var industryStaticLabel: UILabel!
    @IBOutlet weak var countryStaticLabel: UILabel!
    @IBOutlet weak var currencyStaticLabel: UILabel!
    
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
        setupLogoImage()
        getStockDetails()
    }
    
    private func setupVC(stockDetails: StockDetailsModel) {
        currencyStaticLabel.text = "Currency:"
        countryStaticLabel.text = "Country:"
        industryStaticLabel.text = "Industry:"
        marketCapStaticLabel.textColor = .black
        
        industryLabel.text = stockDetails.finnhubIndustry
        companyNameLabel.text = stockDetails.name
        currencyLabel.text = stockDetails.currency
        countryLabel.text = stockDetails.country
        marketCapLabel.text = "$"+String(format: "%.0f", (stockDetails.marketCapitalization/1000))+" mln"
        logoImage.image = downloadSVG(urlString: stockDetails.logo)
        
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


extension StockDetailsVC {
   private func downloadSVG(urlString: String) -> UIImage? {
            let url = URL(string: urlString)
            let svg = SVGKImage(contentsOf: url)
            return svg?.uiImage
        }
    
    private func setupLogoImage() {
        logoImage.layer.cornerRadius = logoImage.bounds.height/3
    }
}
