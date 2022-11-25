//
//  NewsViewController.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let dataFetcherService = DataFetcherService()
    private let mainStocksListDataHandler = MainStocksListLoader()
    private let newsFeedHandler = NewsFeedLoader()
    
    private var newsArray = [NewsModel]()
    private var filteredNewsArray = [NewsModel]()
    private var stocks = [String]()
    
    private let tableView = UITableView()
    private var imageView = UIImageView()
    private let refreshControll = UIRefreshControl()
    private var activityIndicator = UIActivityIndicatorView()
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
        setupViews()
        setConstraints()
        configureTableView()
        setupSearchBar()
        loadStockListFromStorage()
        setupActivityIndicator()
        setupRefreshControll()
        loadNewsFeed()
    }
}

//MARK: - Configure UI elements

extension NewsViewController {
    
    private func setupViews() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - table view delegate and data source

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredNewsArray.count
        } else {
            return newsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {return UITableViewCell()}
        if isFiltering {
            cell.configureCell(data: filteredNewsArray[indexPath.row])
        } else {
            cell.configureCell(data: newsArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailsView = NewsDetailsVC()
        newsDetailsView.newsModel = newsArray[indexPath.row]
        newsDetailsView.modalPresentationStyle = .fullScreen
        self.present(newsDetailsView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Fetch news feed

extension NewsViewController {
    private func loadNewsFeed() {
        startActivitiIndicator()
        newsFeedHandler.loadNewsArray(tikersArray: stocks) { [weak self] loadedArray in
            guard let strongSelf = self else {return}
            guard let safeArray = loadedArray else {return}
            strongSelf.newsArray = safeArray.sorted(by: {$1.datetime < $0.datetime})
            DispatchQueue.main.async {
                strongSelf.stopActivityIndicator()
                strongSelf.tableViewAnimation()
            }
        }
    }
}

//MARK: - UIRefreshControl

extension NewsViewController {
    
    @objc private func refreshTableView(sender: UIRefreshControl) {
        newsArray.removeAll()
        loadStockListFromStorage()
        loadNewsFeed()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControll.endRefreshing()
        }
    }
    
    private func setupRefreshControll() {
        tableView.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        
    }
}

//MARK: - Storage stock list

extension NewsViewController {
    private func loadStockListFromStorage() {
        let userDefaults = UserDefaults.standard
        if let array = userDefaults.stringArray(forKey: "mainList") {
            if array.count > 0 {
                stocks = array
            }
        }
    }
}

//MARK: - Searh bar

extension NewsViewController: UISearchBarDelegate {
    
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

//MARK: - Search results

extension NewsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        let text = searchText.uppercased()
        filteredNewsArray = newsArray.filter({ $0.related.contains(text) })
        tableView.reloadData()
    }
}

//MARK: - Activity Indicator and Table View animation

extension NewsViewController {
    
    private func setupActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.color = .systemGray
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        
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
    
    private func tableViewAnimation() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.height
        var delay = 0.0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            UIView.animate(withDuration: 1.2,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { cell.transform = CGAffineTransform.identity },
                           completion: nil)
            delay += 1
        }
    }
}


