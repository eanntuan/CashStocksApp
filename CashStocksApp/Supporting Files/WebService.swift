//
//  WebService.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/14/21.
//

import Foundation

class Webservice {
  
  func getStocks(url: String?, completion: @escaping (Response?, Error?) -> Void) {
    let stockUrl = url ?? "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json"
    
    guard let url = URL(string: stockUrl) else {
      fatalError("URL is not correct!")
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil, error)
        return
      }
      do {
        let response = try JSONDecoder.defaultDecoder.decode(Response.self, from: data)
        completion(response, nil)
      } catch {
        print("\(#function): \(error)")
        completion(nil, error)
      }
      
    }.resume()
  }
  
}
