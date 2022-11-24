//
//  SearchViewController.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import UIKit


class SearchViewController: UIViewController {
    
    private let searchedStocksPresenter = SearchedStocksDataHandler()
    private var timer: Timer?
    
    var arrayWithAddedStocks = [String]()
    private var stocksForSearchCellArray = [StockForSearchCell]()
    
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    var delegate: PassSearchResultsProtocol?
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true) {
            self.delegate?.getSearchResults(arrayWithSearchResults: self.arrayWithAddedStocks)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        
    }
    
}

//MARK: - Search bar

extension SearchViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.performSearchRequest(text: searchText)
        })
    }
}

//MARK: - Table view

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        navigationItem.title = "Search"
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return stocksForSearchCellArray.count > 0 ? 0 : 250
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksForSearchCellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.showAlertDelegate = self
        cell.returnArrayDelegate = self
        cell.arrayWithAddedStocks = arrayWithAddedStocks
        cell.entireSearchedStocksArray = stocksForSearchCellArray
        cell.setupSearchCell(stock: stocksForSearchCellArray[indexPath.row])
        cell.indexPath = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)!.checkSymbol(symbol: stocksForSearchCellArray[indexPath.row].ticker) {
            self.wrongTickerAlert(name: "No details info available")
        } else {
            self.presentStockDetailsScreen(ticker: stocksForSearchCellArray[indexPath.row].ticker)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
}

//MARK: - Networking service

extension SearchViewController {
    
    private func performSearchRequest(text: String?) {
        guard let text = text else {return}

        searchedStocksPresenter.getStockSearchingResults(text: text) { [weak self] SearchedStocksArray in
            guard let strongSelf = self else {return}
            strongSelf.stocksForSearchCellArray = SearchedStocksArray
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
}

//MARK: - Protocols extensions

extension SearchViewController: AddTickerToStockListProtocol, ShowAlertProtocol, ReturnSearchResultsArrayProtocol {
    
    func getSearchStocksArrayBack(array: [StockForSearchCell]) {
        stocksForSearchCellArray = array
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func showAlert(message: String) {
        wrongTickerAlert(name: message)
    }
    
    
    func getTickerFromSearchScreen(ticker: String) {
        arrayWithAddedStocks.append(ticker)
        
    }
}




