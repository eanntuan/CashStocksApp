//
//  StockManager.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/14/21.
//

import Foundation

class StockManager: NSObject {
  
  static let shared = StockManager()
  var stocks: [Stock] = []
  
  static var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter
  }
  
  func getStockPrices() {
    Webservice().getStocks(url: nil) { response, error  in
      if let stocks = response?.stocks {
        self.stocks = stocks
      }
    }
  }
}
