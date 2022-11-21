//
//  NewsCell.swift
//  My Stocks
//
//  Created by Dmitry on 21.11.2022.
//

import UIKit

class NewsCell: UITableViewCell {
    
    private let timeConverter = TimeConverter()

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourcelabel: UILabel!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data: NewsModel) {
        newsHeadlineLabel.text = data.headline
        timeLabel.text = timeConverter.convertTimeStampToTimeString(stamp: data.datetime)["time"]
        dateLabel.text = timeConverter.convertTimeStampToTimeString(stamp: data.datetime)["date"]
        sourcelabel.text = data.source
        
    }
}
