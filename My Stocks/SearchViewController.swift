//
//  SearchViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit


class SearchViewController: UIViewController {
    
    let searchStockManager = SearchStocksManager()
    var stocks = [Stocks]()
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var delegate: PassSearchResultsProtocol?
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true) {
            //self.delegate?.getSearchResults(newArray: ["AAPL", "TSLA"])
        }
    }
    
    override func viewDidLoad() {
        searchStockManager.performRequest(stockName: "Apple") { stockArray in
            self.stocks = stockArray.result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupTableView() {
        navigationItem.title = "Search"
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.setupSearchCell(stock: stocks[indexPath.row])
        return cell
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        print(text)
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
}
