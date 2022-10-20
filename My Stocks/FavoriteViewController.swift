//
//  FavoriteViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControll = UIRefreshControl()
//    let refreshControll: UIRefreshControl = {
//        let refreshControll = UIRefreshControl()
//        refreshControll.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
//        return refreshControll
//    }()
    var timer = Timer()
    let emptyStock = StockModel()
    var stocksArray = [StockModel]()
    var tikersArray = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        //
        setupRefreshControll()
        loadFavoriteStocksFromStorage()
        super.viewDidLoad()
        if stocksArray.isEmpty {
            stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        }
        setupSearchBar()
        setupTableView()
        getStocksData()
    }
    
    @objc private func refreshTableView(sender: UIRefreshControl) {
        print("endRefreshing")
        loadFavoriteStocksFromStorage()
        stocksArray.removeAll()
        if stocksArray.isEmpty {
            stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        }
        DispatchQueue.main.async {
            self.getStocksData()
            self.tableView.reloadData()
        }
        refreshControll.endRefreshing()
    }
    
    func setupRefreshControll() {
        tableView.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        print(text)
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Here is no your favorite stocks. Add some!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return stocksArray.count > 0 ? 0 : 250
    }
    
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
    
    
    private func getStocksData() {
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
    
    private func loadFavoriteStocksFromStorage() {
        let defaults = UserDefaults.standard
        if let array = defaults.stringArray(forKey: "favorite") {
            tikersArray = array
        }
    }
    
}



