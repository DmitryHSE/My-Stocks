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
    private var stockImageHandler = StockImageHandler()
    private let imageLoaderService = ImageLoaderService()
    @IBOutlet weak var tableView: UITableView!
    private let refreshControll = UIRefreshControl()
    private let emptyStock = StockModel()
    private let emptyDetail = StockDetailsModel()
    private var activityIndicator = UIActivityIndicatorView()
    
    private var filteredStocksArray = [StockModel]()
    private var stocksArray = [StockModel]()
    private var stocksDetailArray = [StockDetailsModel]()
    private var logoArray = [UIImage]()
    private var tikersArray = ["AAPL","TWTR","MSFT","TSLA", "AMZN"]
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStorageForMainStockList()
        setupArrayForGetData()
        setupRefreshControll()
        setupActivityIndicator()
        setupSearchBar()
        setupTableView()
        getStocksData()
        removeEmptyImageFromLogo()
        setupSearchButton()
    }
    
    private func setupArrayForGetData() {
        if stocksArray.isEmpty {
            stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
            logoArray = Array(repeating: UIImage(), count: tikersArray.count)
            stocksDetailArray = Array(repeating: emptyDetail, count: tikersArray.count)
        }
    }
    
}


//MARK: - Storage

extension StocksViewController {
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

//MARK: - Activity indicator

extension StocksViewController {
    
    private func setupActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.color = .systemGray
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        // view did load
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    private func startActivitiIndicator() {
        tableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        tableView.isHidden = false
        self.activityIndicator.stopAnimating()
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
}

//MARK: - Table view

extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
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
                    self.logoArray.remove(at: index)
                    self.stocksDetailArray.remove(at: index)
                    for i in ["mainList"] {
                        self.dataStorageManager.removeStockFromStorage(ticker: editingRow, key: i)
                    }
                } else {
                    self.stocksArray.remove(at: index)
                    self.tikersArray.remove(at: index)
                    self.logoArray.remove(at: index)
                    self.stocksDetailArray.remove(at: index)
                    for i in ["mainList"] {
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
        if isFiltering {
            cell.ticker = filteredStocksArray[indexPath.row].stockName
            cell.setupCell(stockModel: filteredStocksArray[indexPath.row],logo: logoArray[indexPath.row],stockDetails: stocksDetailArray[indexPath.row])
        } else {
            cell.ticker = stocksArray[indexPath.row].stockName
            cell.setupCell(stockModel: stocksArray[indexPath.row],logo: logoArray[indexPath.row],stockDetails: stocksDetailArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chartVC = ChartViewController()
        chartVC.configureView(model: stocksArray[indexPath.row], details: stocksDetailArray[indexPath.row],logo: logoArray[indexPath.row])
        chartVC.modalPresentationStyle = .fullScreen
        self.present(chartVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Get Search Results from Search VC (Protocol)

extension StocksViewController: PassSearchResultsProtocol {
    
    func getSearchResults(arrayWithSearchResults: [String])  {
        tikersArray = arrayWithSearchResults
        stocksArray.removeAll()
        stocksArray = Array(repeating: emptyStock, count: tikersArray.count)
        logoArray.removeAll()
        logoArray = Array(repeating: UIImage(), count: tikersArray.count)
        stocksDetailArray.removeAll()
        stocksDetailArray = Array(repeating: emptyDetail, count: tikersArray.count)
        getStocksData()
        removeEmptyImageFromLogo()
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
        performSegue(withIdentifier: "SearchVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchVC" {
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.arrayWithAddedStocks = tikersArray
            destinationVC.delegate = self
        }
    }
}

//MARK: - Refresh controll (drag tableview down)

extension StocksViewController {
    
    @objc private func refreshTableView(sender: UIRefreshControl) {
        getStocksData()
        removeEmptyImageFromLogo()
        stopActivityIndicator()
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
        startActivitiIndicator()
        stockListPresenter.loadStocksList(tikersArray: tikersArray) { [weak self] index, stock in
            guard let strongSelf = self else {return}
            guard let stock = stock else {return}
            strongSelf.stocksArray[index] = stock
//            DispatchQueue.main.async {
//                strongSelf.tableView.reloadData()
//            }
        }
        stockImageHandler.fethStockImage(tikersArray: tikersArray) { [weak self] index, stock in
            guard let strongSelf = self else {return}
            guard let stock = stock else {return}
            strongSelf.stocksDetailArray[index] = stock
            guard let url = URL(string: stock.logo) else {return}
            strongSelf.imageLoaderService.loadImage(from: url) { image in
                guard let safeImage = image else { return }
                strongSelf.logoArray[index] = safeImage
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                    strongSelf.stopActivityIndicator()
                }
            }
        }
    }
    private func removeEmptyImageFromLogo() {
        for (i,j) in logoArray.enumerated() {
            if j.scale == 1 {
                logoArray[i] = UIImage(named: "sqr")!
            }
        }
    }
}

