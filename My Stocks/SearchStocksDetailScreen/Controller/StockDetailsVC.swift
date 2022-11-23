//
//  StockDetailsVC.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import UIKit
import SVGKit

class StockDetailsVC: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    
    private let imageLoaderService = ImageLoaderService()
    private let dataFetcherService = DataFetcherService()
    var ticker = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true //скрыли индикатор
        activityIndicator.hidesWhenStopped = true //скрываем индикатор если его стопят
        getStockDetails()
    }

    @IBAction func returnButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: - Set up view controller

extension StockDetailsVC {
    
    private func setupUIElements(stockDetails: StockDetailsModel) {
        currencyStaticLabel.text = "Currency:"
        countryStaticLabel.text = "Country:"
        industryStaticLabel.text = "Industry:"
        marketCapStaticLabel.textColor = .black
        
        industryLabel.text = stockDetails.finnhubIndustry
        companyNameLabel.text = stockDetails.name
        currencyLabel.text = stockDetails.currency
        countryLabel.text = stockDetails.country
        logoImage.layer.cornerRadius = logoImage.frame.height/2
        marketCapLabel.text = "$"+String(format: "%.0f", (stockDetails.marketCapitalization/1000))+" mln"
        logoImage.image = downloadSVG(urlString: stockDetails.logo)
//        imageLoaderService.loadImage(from: URL(string: stockDetails.logo)!) { image in
//            self.logoImage.image = image
//        }
        
    }
    
    private func getStockDetails() {
        activityIndicator.isHidden = false // вернули индикатор
        activityIndicator.startAnimating() // стали крутить индикатор
        dataFetcherService.fetchStockDetailsData(stockName: ticker) { stockDetails in
            guard let stock = stockDetails else {return}
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.setupUIElements(stockDetails: stock)
            }
        }
    }
    
    private func downloadSVG(urlString: String) -> UIImage? {
        let url = URL(string: urlString)
        let svg = SVGKImage(contentsOf: url)
        return svg?.uiImage
    }
    
//    private func setupLogoImage() {
//        logoImage.layer.cornerRadius = logoImage.bounds.height/3
//    }
}
