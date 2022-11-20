//
//  TestVC.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit

class TestViewController: UIViewController {
    
    private let dataFetcherService = DataFetcherService()
    private let mainStocksListDataHandler = MainStocksListDataHandler()
    private var newsArray = [NewsModel]()
    private let stocks = ["AAPL", "TSLA"]
    private let tableView = UITableView()
    private var imageView = UIImageView()
    
    private let imageLoaderService = ImageLoaderService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //view.addSubview(tableView)
        //tableView.frame = view.bounds
        let url = URL(string: "https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/AAPL.svg")!
        imageLoaderService.loadImage(from: url) { image in
            self.imageView.image = image
        }
        //imageView.loadImage(from: "https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/AAPL.svg")
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        view.addSubview(imageView)
//        dataFetcherService.fetchNews(stockName: "AAPL") { array in
//            guard let model = array else {return}
//            for i in model {
//                print(i.headline)
//            }
//        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainStocksListDataHandler.loadNews(tikersArray: stocks) { [weak self] array in
            guard let self = self else {return}
            self.newsArray += array
            self.newsArray = self.newsArray.sorted(by: {$1.datetime < $0.datetime})
            self.tableView.reloadData()
        }
        
        
        view.backgroundColor = .systemMint
    }
    
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = newsArray[indexPath.row].headline
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.font = UIFont(name: "Arial Bold", size: 14)
        return cell
    }
}


