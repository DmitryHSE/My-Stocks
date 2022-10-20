//
//  FavoriteViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var timer = Timer()
    let emptyStock = StockModel()
    var stocksArray = [StockModel]()
    
    var tikersArray = ["AAPL","TWTR","MSFT","TSLA", "AMZN","GOOG", "META", "JNJ","XOM","V"]
    let searchController = UISearchController(searchResultsController: nil)
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if stocksArray.isEmpty {
            stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        }
        setupSearchBar()
        setupTableView()
        getStocksData()
        //setupSearchButton()
    
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        print(text)
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StockCell
        if indexPath.row % 2 == 0 {
            cell.backgroundImage.backgroundColor = UIColor(hexString: "f9f4ff")
        } else {
            cell.backgroundImage.backgroundColor = .white
        }
        cell.setupCell(stockModel: stocksArray[indexPath.row])
        cell.favoriteButton.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentStockDetailsScreen(ticker: stocksArray[indexPath.row].stockName)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteViewController {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchVC" {
            print("performing segue")
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.arrayWithAddedStocks = tikersArray
            destinationVC.delegate = self
        }
    }
    
    private func getStocksData() {
        print("getStocksData")
        getStocksArray(tikersArray: tikersArray) { index, stock in
            self.stocksArray[index] = stock
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let nib = UINib(nibName: "StockCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
}

//MARK: - PassSearchResultsProtocol

extension FavoriteViewController: PassSearchResultsProtocol {
    
    func getSearchResults(arrayWithSearchResults: [String])  {
        tikersArray = arrayWithSearchResults
        stocksArray.removeAll()
        stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        getStocksData()
    }
}
