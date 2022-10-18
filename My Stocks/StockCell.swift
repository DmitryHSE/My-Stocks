//
//  StockCell.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class StockCell: UITableViewCell {

    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.layer.cornerRadius = backgroundImage.frame.height/2
        backgroundImage.clipsToBounds = true
    }

    
    
}
