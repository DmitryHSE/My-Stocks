//
//  SearchViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit


class SearchViewController: UIViewController {
    var delegate: PassSearchResultsProtocol?
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true) {
            self.delegate?.getSearchResults(newArray: ["AAPL", "TSLA"])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
}
