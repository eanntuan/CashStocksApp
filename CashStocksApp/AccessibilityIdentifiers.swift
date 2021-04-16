//
//  AccessibilityIdentifiers.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/15/21.
//

import Foundation

import UIKit

public struct AccessibilityIdentifiers {
  
  public static let BackButton = "BackButton"

  public static let ErrorCell = "ErrorCell"
  
  public struct StockDetails {
    public static let TickerLabel = "TickerLabel"
    public static let NameLabel = "NameLabel"
    public static let PriceLabel = "PriceLabel"
    public static let QuantityLabel = "QuantityLabel"
    public static let TotalValueLabel = "TotalValueLabel"
    public static let InfoLabel = "InfoLabel"
  }
  
  public struct StockCell {
    public static let StockCell = "StockCell"
    public static let TickerLabel = "TickerLabel"
    public static let NameLabel = "NameLabel"
    public static let PriceLabel = "PriceLabel"
    public static let QuantityLabel = "QuantityLabel"
  }
  
  public struct LoadingCell {
    public static let LoadingCell = "LoadingCell"
    public static let ActivityIndicator = "ActivityIndicator"
    public static let InfoLabel = "InfoLabel"
  }
  
}
