//
//  StocksTableViewController.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/14/21.
//

import Foundation
import UIKit

class StocksTableViewController: UITableViewController {
  
  // MARK: - State
  
  enum State {
    case loading
    case loaded([Stock])
    case empty
    case error
  }
  
  var stocks: [Stock] = []
  var filteredStocks: [Stock] = []
  var tableState: State = .empty
  
  private var retryCounter = 1.0
  private var getStocksRetryTimer: Timer?
  private var isRetrying = false
  private var isFetchingStocks = false
  
  @IBAction func refreshValueChanged(_ sender: UIRefreshControl) {
    refetchStocks()
  }
  
  let searchController = UISearchController(searchResultsController: nil)
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    fetchStockPrices()
    
    tableView.separatorInset.left = 0
    tableView.backgroundColor = UIColor.black
    tableView.register(UINib(nibName: "StockCell", bundle: nil), forCellReuseIdentifier: "stock")
    tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.setTitle("Stocks")
    navigationController?.navigationBar.tintColor = .white
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.tableView.refreshControl?.endRefreshing()
    }
  }
  
  func refetchStocks() {
    getStocksRetryTimer?.invalidate()
    tableState = .loading
    self.getStocksRetryTimer = Timer.scheduledTimer(withTimeInterval: self.retryCounter, repeats: false, block: { (_) in
      print("Retrying Stock Counter \(self.retryCounter)")
      self.fetchStockPrices()
      self.retryCounter *= 2.0
    })
  }
  
  func setupSearchBar() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if stocks.isEmpty {
      return 1
    } else {
      return isFiltering ? filteredStocks.count : stocks.count
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if stocks.isEmpty {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else { return UITableViewCell() }
      cell.configure(tableState: tableState)
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "stock", for: indexPath) as? StockCell else { return UITableViewCell() }
      let stock = isFiltering ? filteredStocks[indexPath.row] : stocks[indexPath.row]
      cell.stock = stock
      cell.configure(indexPath)
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let stock = isFiltering ? filteredStocks[indexPath.row] : stocks[indexPath.row]
    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StockDetailsViewController") as? StockDetailsViewController {
      vc.stock = stock
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  
  private func fetchStockPrices() {
    print(#function)
    guard !isFetchingStocks else { return }
    isFetchingStocks = true
    Webservice().getStocks(url: nil) { [self] response, error in
      
      guard error == nil else {
        self.tableState = .error
        self.reloadData()
        return
      }
      
      // Ideally check to see if the new stocks and old stocks are different to determine if we should reload
      if let stocks = response?.stocks {
        self.stocks = stocks
        self.tableState = stocks.isEmpty ? .empty : .loaded(stocks)
        self.reloadData()
      }
      self.isFetchingStocks = false
    }
  }
  
  func filterContentForSearchText(_ searchText: String) {
    filteredStocks = stocks.filter { (stock: Stock) -> Bool in
      return stock.name.lowercased().contains(searchText.lowercased()) || stock.ticker.lowercased().contains(searchText.lowercased())
    }
    tableView.reloadData()
  }
  
}

extension StocksTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}

extension UINavigationItem {
  
  func setTitle(_ title: String) {
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "PST")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "MM-dd-YYYY HH:mm"
    
    let appearance = UINavigationBar.appearance()
    let textColor = appearance.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? .black
    
    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
    titleLabel.textColor = textColor
    
    let subtitleLabel = UILabel()
    subtitleLabel.text = dateFormatter.string(from: date)
    subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    subtitleLabel.textColor = textColor.withAlphaComponent(0.75)
    
    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.distribution = .equalCentering
    stackView.alignment = .center
    stackView.axis = .vertical
    
    self.titleView = stackView
  }
  
}

extension Array where Element: Hashable {
  func difference(from other: [Element]) -> [Element] {
    let thisSet = Set(self)
    let otherSet = Set(other)
    return Array(thisSet.symmetricDifference(otherSet))
  }
}
