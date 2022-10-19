//
//  SearchCell.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var stockTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupSearchCell(stock: Stocks) {
        companyLabel.text = stock.description
        tickerLabel.text = stock.symbol
        if stock.type == "" {
            stockTypeLabel.text = "Type not available"
        } else {
        stockTypeLabel.text = stock.type
        }
    }


    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("Add button tapped!")
    }
}
