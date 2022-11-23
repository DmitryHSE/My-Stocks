//
//  DetailedNewsView.swift
//  My Stocks
//
//  Created by Dmitry on 21.11.2022.
//

import UIKit

class DetailedNewsView: UIView {
   
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    
    var delegate: DismissProtocol?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        delegate?.performDismiss()
    }
}
