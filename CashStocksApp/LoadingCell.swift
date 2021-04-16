//
//  LoadingCell.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/15/21.
//

import Foundation
import UIKit

final class LoadingCell: UITableViewCell {

  @IBOutlet weak var loadingLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  func configure(tableState: StocksTableViewController.State) {
    switch tableState {
    case .error:
      activityIndicator.isHidden = true
      loadingLabel.text = "There was an error loading the stocks. Please try again or contact Steve Jobs for support."
    case .empty:
      activityIndicator.isHidden = true
      loadingLabel.text = "Ooops! Looks like there aren't any stocks to report. Please try again or contact Steve Jobs for support."
    default:
      activityIndicator.startAnimating()
      loadingLabel.text = "Please hold while we try to make you money... :)"
    }
    self.accessibilityLabel = AccessibilityIdentifiers.LoadingCell.LoadingCell
    loadingLabel.accessibilityLabel = AccessibilityIdentifiers.LoadingCell.InfoLabel
    activityIndicator.accessibilityLabel = AccessibilityIdentifiers.LoadingCell.ActivityIndicator
  }

}

