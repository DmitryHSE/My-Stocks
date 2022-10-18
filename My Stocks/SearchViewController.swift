//
//  SearchViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

protocol PassSearchResultsProtocol {
    func getSearchResults(newArray: [String])
}

class SearchViewController: UIViewController {
    var delegate: PassSearchResultsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.getSearchResults(newArray: ["AAPL", "TSLA"])
        }
    }
    
}
