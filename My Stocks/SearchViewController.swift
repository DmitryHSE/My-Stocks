//
//  SearchViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit


class SearchViewController: UIViewController {
    
    private var timer: Timer?
    private let searchStockManager = SearchStocksManager()
    private var stocks = [Stocks]()
    
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    var delegate: PassSearchResultsProtocol?
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true) {
            //self.delegate?.getSearchResults(newArray: ["AAPL", "TSLA"])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.performSearchRequest(text: searchText)
        })
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


//extension SearchViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else {return}
//        print(text)
//    }


extension SearchViewController {
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        navigationItem.title = "Search"
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        
    }
    
    private func performSearchRequest(text: String?) {
        guard let text = text else {return}
        searchStockManager.performRequest(stockName: text) { stockArray in
            self.stocks = stockArray.result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
