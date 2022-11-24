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
}

//MARK: - Configure UI Elements

extension NewsDetailsVC {
    
    private func setupViews() {
        newsView.translatesAutoresizingMaskIntoConstraints = false
        newsView = Bundle.main.loadNibNamed("DetailedNewsView", owner: self, options: nil)?.first as! DetailedNewsView
        view.addSubview(newsView)
    }
    
    private func configureNewsView() {
        newsView.delegate = self
        newsView.headerLabel.text = newsModel?.headline ?? ""
        newsView.timeLable.text = timeConverter.convertTimeStampToTimeString(stamp: newsModel.datetime)["time"]
        newsView.dateLabel.text = timeConverter.convertTimeStampToTimeString(stamp: newsModel.datetime)["date"]
        newsView.textView.text = newsModel.summary
    }
    
    private func setConstraints() {
        newsView.center = view.center
    }
}

//MARK: - Go orevious screen protocols extensions

extension NewsDetailsVC: DismissProtocol {
    func performDismiss() {
        self.dismiss(animated: true)
    }
}


