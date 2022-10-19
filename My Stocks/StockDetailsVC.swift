//
//  StockDetailsVC.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import UIKit

class StockDetailsVC: UIViewController {
    
    var ticker = String()
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC(ticker: ticker)
    }
    
    private func setupVC(ticker: String) {
        testLabel.text = ticker
    }
}
