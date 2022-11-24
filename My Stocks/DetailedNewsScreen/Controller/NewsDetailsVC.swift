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
        newsView.timeLable.text = timeConverter.convertTimeStampToTimeDict(stamp: newsModel.datetime)[PeriodUnit.time.rawValue]
        newsView.dateLabel.text = timeConverter.convertTimeStampToTimeDict(stamp: newsModel.datetime)[PeriodUnit.date.rawValue]
        newsView.textView.text = newsModel.summary
    }
    
    private func setConstraints() {
        newsView.center = view.center
    }
}

//MARK: - Go previous screen protocols extensions

extension NewsDetailsVC: DismissProtocol {
    func performDismiss() {
        self.dismiss(animated: true)
    }
}


