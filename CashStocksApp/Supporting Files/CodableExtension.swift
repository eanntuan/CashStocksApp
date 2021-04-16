//
//  CodableExtension.swift
//  CashStocksApp
//
//  Created by Eann Tuan on 4/14/21.
//

import Foundation

extension JSONEncoder {
    static let defaultEncoder = JSONEncoder(dateEncodingStrategy: .iso8601)
    convenience init(dateEncodingStrategy: DateEncodingStrategy) {
        self.init()
        self.keyEncodingStrategy = .convertToSnakeCase
        self.dateEncodingStrategy = dateEncodingStrategy
    }
}

extension JSONDecoder {
    static let defaultDecoder = JSONDecoder(dateDecodingStrategy: .iso8601)
    convenience init(dateDecodingStrategy: DateDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
