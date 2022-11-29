//
//  UIViewControllerExtensions.swift
//  My Stocks
//
//  Created by Dmitry on 24.11.2022.
//


import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller  in \(name) storyboard")
        }
    }
    
    func wrongTickerAlert(name: String) {
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertOk)
        present(alertController, animated: true, completion: nil )
    }
    
    func typeOfNewsPresentation(url: String,dataForCell: NewsModel) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openCell = UIAlertAction(title: "Read the short version", style: .default) { (action) in
            let newsDetailsView = NewsDetailsVC()
            newsDetailsView.newsModel = dataForCell
            newsDetailsView.modalPresentationStyle = .fullScreen
            self.present(newsDetailsView, animated: true)
        }
        let goToSafari = UIAlertAction(title: "Go to source", style: .default) { (action) in
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        actionSheet.addAction(openCell)
        actionSheet.addAction(goToSafari)
        actionSheet.addAction(cancelButton)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func presentStockDetailsScreen(ticker: String) {
        let VC: StockDetailsVC = StockDetailsVC.loadFromStoryboard()
        VC.ticker = ticker
        self.present(VC, animated: true)
    }
}
