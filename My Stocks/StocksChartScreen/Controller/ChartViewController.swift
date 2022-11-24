//
//  ChartViewController.swift
//  My Stocks
//
//  Created by Dmitry on 23.11.2022.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    //MARK: - Logo image
    
    private var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    
    //MARK: - Stock name label
    
    private var stockNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apple Inc."
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 26)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    //MARK: - Exit button
    
    private var exitButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(returnToStockList), for: .touchUpInside)
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()
    
    //MARK: - Discribing labels
    
    private var backView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 30
        return view
    }()
    
    private var lastPriceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last price:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var oneYearHighLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1y high:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var oneYearLowLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1y low:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var oneYearChangeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1y change:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var marketCapLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MarketCap:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
       // label.backgroundColor = .systemPink
        return label
    }()
    
    private var industryLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Industry:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
       // label.backgroundColor = .systemPink
        return label
    }()
    
    private var countryLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Country:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    private var currencyLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Courency:"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    //MARK: - value labels
    
    private var lastPriceLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var oneYearHighLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var oneYearLowLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
       // label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var oneYearChangeLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
       // label.backgroundColor = .systemPink
        
        return label
    }()
    
    private var marketCapLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    private var industryLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
        //label.backgroundColor = .systemPink
        return label
    }()
    
    private var countryLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
       // label.backgroundColor = .systemPink
        return label
    }()
    
    private var currencyLabelValue: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next", size: 20)
       // label.backgroundColor = .systemPink
        return label
    }()
    
    lazy var candleChartView: CandleStickChartView = {
        let chartView = CandleStickChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.leftAxis.enabled = false
        chartView.drawBordersEnabled = true
        chartView.dragYEnabled = true
        chartView.dragEnabled = true
        chartView.rightAxis.labelFont = UIFont(name: "Arial", size: 14)!
        chartView.xAxis.labelFont = UIFont(name: "Arial", size: 14)!
        chartView.xAxis.labelPosition = .bottom
        chartView.animate(xAxisDuration: 2)
        chartView.highlightPerDragEnabled = true
        chartView.xAxis.labelRotationAngle = 315
        chartView.xAxis.setLabelCount(12, force: false)
        let currentMonth = getCurrentMonth()
        chartView.xAxis.valueFormatter = MonthNumberFormatter(startMonthIndex: currentMonth!)
        return chartView
    }()
    
    //MARK: - properties
    
    private var newSet = CandleChartDataSet()
    var stockName = String()
    private var stockModel = StockModel()
    private var stocksDetailModel = StockDetailsModel()
    private var logoArray = [UIImage]()
    
    private let dataFetcherService = DataFetcherService()
    private var chartData: ChartModel!
    private var dataQuotesArray = [CandleChartDataEntry]()
    private let timeConverter = TimeConverter()
    private var oneYearPriceChange = String()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        fetchQuotes()
    }
    
    func configureView(model: StockModel, details:StockDetailsModel, logo: UIImage) {
        stockName = model.stockName
        stockNameLabel.text = details.name
        logoImage.image = logo
        lastPriceLabelValue.text = String(format: "%0.1f", model.currentPrice) + "$"
        
        marketCapLabelValue.text = "$"+String(Int(details.marketCapitalization/1000)) + " mln"
        industryLabelValue.text = details.finnhubIndustry
        countryLabelValue.text = details.country
        currencyLabelValue.text = details.currency
    }
    
    @objc func returnToStockList() {
        self.dismiss(animated: true)
    }
}

extension ChartViewController: ChartViewDelegate {
    
    private func setData() {
        returnYearChange()
        newSet = CandleChartDataSet(entries: dataQuotesArray, label: stockNameLabel.text!)
        let data = CandleChartData(dataSet: newSet)
        data.setDrawValues(false)
        newSet.setColor(.black)
        newSet.increasingFilled = false
        newSet.decreasingFilled = true
        newSet.shadowColor = .black
        newSet.barSpace = 0.2
        candleChartView.data = data
        newSet.highlightColor = .darkGray
        newSet.highlightEnabled = false
        
        //set high and low prices
        oneYearHighLabelValue.text = String(format: "%0.1f",newSet.yMax) + "$"
        oneYearLowLabelValue.text = String(format: "%0.1f",newSet.yMin) + "$"
    }
}

extension ChartViewController {
    
    private func fetchQuotes() {
        dataFetcherService.fetchChart(stockName: stockName) { dataArray in
            self.chartData = dataArray
            self.createDataSet()
        }
    }
    
    private func createDataSet() {
        var counter = 0
        while counter < chartData.o.count {
            let entry = CandleChartDataEntry(x: Double(counter), shadowH: chartData.h[counter], shadowL: chartData.l[counter], open: chartData.o[counter], close: chartData.c[counter])
            dataQuotesArray.append(entry)
            counter += 1
        }
        setData()
    }
}


extension ChartViewController {
    private func getCurrentMonth()->Int? {
        let todayDate = Date()
        let myCalendar = NSCalendar(calendarIdentifier: .gregorian)
        let myComponents = myCalendar?.components(.month, from: todayDate)
        let month = myComponents?.month
        return month
    }
    private func returnYearChange() {
        let firstDayPrice = chartData.o[0]
        let lastIndex = chartData.c.count - 1
        let lastDayPrice = chartData.c[lastIndex]
        let change = Double(lastDayPrice/firstDayPrice-1)*100
        oneYearChangeLabelValue.text = String(format: "%0.1f", change) + "%"
    }
}

//MARK: - configure UI

extension ChartViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(candleChartView)
        view.addSubview(logoImage)
        view.addSubview(stockNameLabel)
        view.addSubview(exitButton)
        view.addSubview(backView)
        
        view.addSubview(lastPriceLabel)
        view.addSubview(oneYearHighLabel)
        view.addSubview(oneYearLowLabel)
        view.addSubview(oneYearChangeLabel)
        
        view.addSubview(marketCapLabel)
        view.addSubview(countryLabel)
        view.addSubview(currencyLabel)
        view.addSubview(industryLabel)
        
        view.addSubview(lastPriceLabelValue)
        view.addSubview(oneYearHighLabelValue)
        view.addSubview(oneYearLowLabelValue)
        view.addSubview(oneYearChangeLabelValue)
        
        view.addSubview(marketCapLabelValue)
        view.addSubview(countryLabelValue)
        view.addSubview(currencyLabelValue)
        view.addSubview(industryLabelValue)
    }
    
    
    
    private func setConstraints() {
         NSLayoutConstraint.activate([
             
             // logo image
             
             logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
             logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             logoImage.heightAnchor.constraint(equalToConstant: 30),
             logoImage.widthAnchor.constraint(equalToConstant: 30),
             
             // stock name
             stockNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
             stockNameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 10),
             stockNameLabel.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor, constant: -5),
             stockNameLabel.heightAnchor.constraint(equalToConstant: 30),
             // exit button
             exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
             exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             exitButton.heightAnchor.constraint(equalToConstant: 30),
             exitButton.widthAnchor.constraint(equalToConstant: 30),
             // chart
             candleChartView.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 5),
             candleChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
             candleChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
             candleChartView.heightAnchor.constraint(equalToConstant: 250),
             // labels
             backView.topAnchor.constraint(equalTo: candleChartView.bottomAnchor, constant: 5),
             backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
             backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
             backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
             
             lastPriceLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
             lastPriceLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             lastPriceLabel.heightAnchor.constraint(equalToConstant: 30),
             
             oneYearHighLabel.topAnchor.constraint(equalTo: lastPriceLabel.bottomAnchor, constant: 10),
             oneYearHighLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             oneYearHighLabel.heightAnchor.constraint(equalToConstant: 30),
             
             oneYearLowLabel.topAnchor.constraint(equalTo: oneYearHighLabel.bottomAnchor, constant: 10),
             oneYearLowLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             oneYearLowLabel.heightAnchor.constraint(equalToConstant: 30),
             
             oneYearChangeLabel.topAnchor.constraint(equalTo: oneYearLowLabel.bottomAnchor, constant: 10),
             oneYearChangeLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             oneYearChangeLabel.heightAnchor.constraint(equalToConstant: 30),
             
             marketCapLabel.topAnchor.constraint(equalTo: oneYearChangeLabel.bottomAnchor, constant: 30),
             marketCapLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             marketCapLabel.heightAnchor.constraint(equalToConstant: 30),
             
             industryLabel.topAnchor.constraint(equalTo: marketCapLabel.bottomAnchor, constant: 10),
             industryLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             industryLabel.heightAnchor.constraint(equalToConstant: 30),
             
             countryLabel.topAnchor.constraint(equalTo: industryLabel.bottomAnchor, constant: 10),
             countryLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             countryLabel.heightAnchor.constraint(equalToConstant: 30),
             
             currencyLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
             currencyLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             currencyLabel.heightAnchor.constraint(equalToConstant: 30),
             
             // labels value
             lastPriceLabelValue.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
             lastPriceLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             lastPriceLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             oneYearHighLabelValue.topAnchor.constraint(equalTo: lastPriceLabelValue.bottomAnchor, constant: 10),
             oneYearHighLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             oneYearHighLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             oneYearLowLabelValue.topAnchor.constraint(equalTo: oneYearHighLabelValue.bottomAnchor, constant: 10),
             oneYearLowLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             oneYearLowLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             oneYearChangeLabelValue.topAnchor.constraint(equalTo: oneYearLowLabelValue.bottomAnchor, constant: 10),
             oneYearChangeLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             oneYearChangeLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             marketCapLabelValue.topAnchor.constraint(equalTo: oneYearChangeLabelValue.bottomAnchor, constant: 30),
             marketCapLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             marketCapLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             industryLabelValue.topAnchor.constraint(equalTo: marketCapLabelValue.bottomAnchor, constant: 10),
             industryLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             industryLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             countryLabelValue.topAnchor.constraint(equalTo: industryLabelValue.bottomAnchor, constant: 10),
             countryLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             countryLabelValue.heightAnchor.constraint(equalToConstant: 30),
             
             currencyLabelValue.topAnchor.constraint(equalTo: countryLabelValue.bottomAnchor, constant: 10),
             currencyLabelValue.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             currencyLabelValue.heightAnchor.constraint(equalToConstant: 30)
             
         ])
     }
    
}
