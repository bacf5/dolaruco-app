//
//  Currency.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 17.09.25.
//

import Foundation

struct Currency: Decodable {
    let compra: Int
    let venta: Int
    let casa: String
    let nombre: String
    let moneda: String
    let fechaActualizacion: String
}
