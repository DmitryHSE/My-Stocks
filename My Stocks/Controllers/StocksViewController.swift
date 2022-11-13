//
//  StocksViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class StocksViewController: UIViewController {
    
    private var stockListPresenter = MainStocksListDataHandler()
    private var dataStorageManager = DataStorageManager()
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControll = UIRefreshControl()
    var timer = Timer()
    let emptyStock = StockModel()
    
    var filteredStocksArray = [StockModel]()
    var stocksArray = [StockModel]()
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var tikersArray = ["AAPL","TWTR","MSFT","TSLA", "AMZN","GOOG", "META", "JNJ","XOM","V"]
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStorageForMainStockList()
        if stocksArray.isEmpty {
            stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        }
        setupRefreshControll()
        setupSearchBar()
        setupTableView()
        getStocksData()
        setupSearchButton()
    }
    
    private func setupStorageForMainStockList() {
        let userDefaults = UserDefaults.standard
        if let array = userDefaults.stringArray(forKey: "mainList") {
            if array.count > 0 {
                tikersArray = array
            }
        } else {
            userDefaults.set(tikersArray, forKey: "mainList")
        }
    }
}

//MARK: - Search bar and button

extension StocksViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        print(text)
    }
    
}

//MARK: - Table view

extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let nib = UINib(nibName: "StockCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            var editingRow = ""
            if self.isFiltering {
                editingRow = self.filteredStocksArray[indexPath.row].stockName
            } else {
                editingRow = self.tikersArray[indexPath.row]
            }
           
            if let index = self.tikersArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
    
                    self.filteredStocksArray.remove(at: indexPath.row)
                    self.tikersArray.remove(at: index)
                    self.stocksArray.remove(at: index)
                    for i in ["mainList", "favorite"] {
                        self.dataStorageManager.removeStockFromStorage(ticker: editingRow, key: i)
                    }
                } else {
                    self.stocksArray.remove(at: index)
                    self.tikersArray.remove(at: index)
                    for i in ["mainList", "favorite"] {
                        self.dataStorageManager.removeStockFromStorage(ticker: editingRow, key: i)
                    }
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredStocksArray.count
        } else {
            return stocksArray.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StockCell
        cell.selectionStyle = .none
        if indexPath.row % 2 == 0 {
            cell.backgroundImage.backgroundColor = UIColor(hexString: "f0f0f0")
        } else {
            cell.backgroundImage.backgroundColor = .white
        }
        
        if isFiltering {
            cell.ticker = filteredStocksArray[indexPath.row].stockName
            cell.setupCell(stockModel: filteredStocksArray[indexPath.row])
        } else {
            cell.ticker = stocksArray[indexPath.row].stockName
            cell.setupCell(stockModel: stocksArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentStockDetailsScreen(ticker: stocksArray[indexPath.row].stockName)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Get Search Results from Search VC (Protocol)

extension StocksViewController: PassSearchResultsProtocol {
    func getSearchResults(arrayWithSearchResults: [String])  {
        tikersArray = arrayWithSearchResults
        stocksArray.removeAll()
        stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        getStocksData()
    }
}

//MARK: - Search ticker at table results delegate

extension StocksViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        let text = searchText.uppercased()
        filteredStocksArray = stocksArray.filter({ $0.stockName.contains(text) })
        tableView.reloadData()
    }
}

//MARK: - Bar button item (add new stocks)
extension StocksViewController {
    
    private func setupSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(performAdd(sender:)))
    }
    
    @objc func performAdd(sender: UIBarButtonItem) {
        print(filteredStocksArray)
        performSegue(withIdentifier: "SearchVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchVC" {
            print("performing segue")
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.arrayWithAddedStocks = tikersArray
            destinationVC.delegate = self
        }
    }
}

//MARK: - Refresh controll (drag table view down)

extension StocksViewController {
    
    @objc private func refreshTableView(sender: UIRefreshControl) {
        getStocksData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControll.endRefreshing()
        }
    }
    
    func setupRefreshControll() {
        tableView.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        
    }
}

//MARK: - Networking service

extension StocksViewController {
    private func getStocksData() {
        stockListPresenter.loadStocksList(tikersArray: tikersArray) { index, stock in
            guard let stock = stock else {return}
            self.stocksArray[index] = stock
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


