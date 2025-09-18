//
//  DoubleExtension.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 18.09.25.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "N/A"
    }
}
