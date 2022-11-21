//
//  NewsViewController.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let dataFetcherService = DataFetcherService()
    private let mainStocksListDataHandler = MainStocksListDataHandler()
    private var newsArray = [NewsModel]()
    private var stocks = [String]()// ["AAPL", "TSLA"]
    private let tableView = UITableView()
    private var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        setConstraints()
        setupStorageForMainStockList()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
        
        mainStocksListDataHandler.loadNews(tikersArray: stocks) { [weak self] array in
            guard let self = self else {return}
            self.newsArray += array
            self.newsArray = self.newsArray.sorted(by: {$1.datetime < $0.datetime})
            self.tableView.reloadData()
            
        }
        
        
        view.backgroundColor = .white
    }
    
    private func setupStorageForMainStockList() {
        let userDefaults = UserDefaults.standard
        if let array = userDefaults.stringArray(forKey: "mainList") {
            if array.count > 0 {
                stocks = array
            }
        } else {
            userDefaults.set(stocks, forKey: "mainList")
        }
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {return UITableViewCell()}
//        cell.textLabel?.text = newsArray[indexPath.row].headline
//        cell.textLabel?.numberOfLines = 3
//        cell.textLabel?.font = UIFont(name: "Arial Bold", size: 14)
        cell.configureCell(data: newsArray[indexPath.row])
        //cell.newsBodyLabel.text = newsArray[indexPath.row].headline
        return cell
    }
}


