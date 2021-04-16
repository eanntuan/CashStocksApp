//
//  StockCell.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/14/21.
//

import Foundation
import UIKit

class StockCell: UITableViewCell {
  
  var stock: Stock?
  
  @IBOutlet weak var stockFullName: UILabel!
  @IBOutlet private weak var stockName: UILabel!
  @IBOutlet private weak var stockPrice: UILabel!
  @IBOutlet private weak var percentageWrapper: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    percentageWrapper.layer.cornerRadius = 5
  }
  
  func configure(_ index: IndexPath) {
    if let stock = stock {
      stockName.text = stock.ticker
      stockPrice.text = "\(stock.priceString)"
      stockFullName.text = stock.name
      // I would ask Product or Backend for future plans of getting a percentage to display like Apple Stocks
      //        stockPercentageChange.text = "\(stock.percentage)"
      //        percentageWrapper.backgroundColor = stock.percentage.first == "+"
      //          ? UIColor.green.withAlphaComponent(0.7)
      //          : UIColor.red
    }
    setupAccessibility(index)
  }
  
  fileprivate func setupAccessibility(_ index: IndexPath) {
    let row = index.row
    stockFullName.accessibilityIdentifier = "\(AccessibilityIdentifiers.StockCell.NameLabel)-\(row)"
    stockName.accessibilityIdentifier = "\(AccessibilityIdentifiers.StockCell.TickerLabel)-\(row)"
    stockPrice.accessibilityIdentifier = "\(AccessibilityIdentifiers.StockCell.QuantityLabel)-\(row)"
  }
}
