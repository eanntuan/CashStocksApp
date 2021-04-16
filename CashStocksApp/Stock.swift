//
//  Stock.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/14/21.
//

import Foundation

typealias StocksCompletion = ((Result<[Stock], Error>) -> Void)

struct Response: Codable {
  var stocks: [Stock]
}

struct Stock: Codable, Hashable, Comparable {
  let ticker: String
  let name: String
  let currentPriceCents: Int
  let currency: String
  let quantity: Int?
  let currentPriceTimestamp: Int
  
  var currentPriceDollars: Double {
    return Double(currentPriceCents/100)
  }
  
  var priceString: String {
    return StockManager.currencyFormatter.string(from: NSNumber(value: currentPriceDollars)) ?? ""
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(currentPriceTimestamp)
  }
  
  static func < (lhs: Stock, rhs: Stock) -> Bool {
      return lhs.currentPriceTimestamp < rhs.currentPriceTimestamp
  }

}
