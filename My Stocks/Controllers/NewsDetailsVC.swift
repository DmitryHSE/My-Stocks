//
//  NewsDetailsVC.swift
//  My Stocks
//
//  Created by Dmitry on 21.11.2022.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    private var newsView = DetailedNewsView()
    private var timeConverter = TimeConverter()
    var newsModel: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        configureNewsView()
    }
    
    func configureNewsView() {
        newsView.headerLabel.text = newsModel?.headline ?? ""
        newsView.timeLable.text = timeConverter.convertTimeStampToTimeString(stamp: newsModel.datetime)["time"]
        newsView.dateLabel.text = timeConverter.convertTimeStampToTimeString(stamp: newsModel.datetime)["date"]
        newsView.textView.text = newsModel.summary
    }
    
    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
//            newsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            newsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
//        ])
        newsView.center = view.center
    }
}

extension NewsDetailsVC {
    private func setupViews() {
        newsView.translatesAutoresizingMaskIntoConstraints = false
        newsView = Bundle.main.loadNibNamed("DetailedNewsView", owner: self, options: nil)?.first as! DetailedNewsView
        view.addSubview(newsView)
    }
}
