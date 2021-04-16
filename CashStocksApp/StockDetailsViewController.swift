//
//  StockDetailsViewController.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/15/21.
//

import Foundation
import UIKit

class StockDetailsViewController: UIViewController {
  
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var totalValueLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var tickerLabel: UILabel!
  
  var stock: Stock?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupAccessibility()
  }
  
  func configureUI() {
    guard let stock = stock else { return }
    let quantity = stock.quantity ?? 0
    let totalValue = quantity * Int(stock.currentPriceDollars)
    quantityLabel.text = "Units: \(quantity)"
    priceLabel.text = stock.priceString
    tickerLabel.text = stock.ticker
    nameLabel.text = stock.name
    totalValueLabel.text = "Total Value: \(stock.currency) \(totalValue)"
    
    if quantity == 0 {
      infoLabel.text = "Time to buy some stock..."
    } else {
      infoLabel.text = "You're on your way to becoming RICH!!"
    }
  }
  
  func setupAccessibility() {
    nameLabel.accessibilityIdentifier = AccessibilityIdentifiers.StockDetails.NameLabel
    priceLabel.accessibilityIdentifier = AccessibilityIdentifiers.StockDetails.PriceLabel
    tickerLabel.accessibilityIdentifier = AccessibilityIdentifiers.StockDetails.TickerLabel
    quantityLabel.accessibilityIdentifier = AccessibilityIdentifiers.StockDetails.QuantityLabel
    totalValueLabel.accessibilityIdentifier = AccessibilityIdentifiers.StockDetails.TotalValueLabel
    infoLabel.accessibilityIdentifier = AccessibilityIdentifiers.StockDetails.InfoLabel
  }
  
}
