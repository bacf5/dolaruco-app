//
//  ViewModel.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 18.09.25.
//

import Foundation
import Combine


@MainActor
class ViewModel: ObservableObject {
    
    @Published var dollars: [DollarViewModel] = []
    @Published var otherCurrencies: [OtherCurrenciesViewModel] = []
    @Published var isLoading = false
    
    func populateDollars() async {
        isLoading = true
        do {
            let dollars = try await FetchService().getCurrency(url: Constants.Urls.dollarApi)
            self.dollars = dollars.map(DollarViewModel.init)
        } catch {
            print(error)
        }
        isLoading = false
    }
    
    func populateOtherCurrencies() async {
        isLoading = true
        do {
            let otherCurrencies = try await FetchService().getCurrency(url: Constants.Urls.otherCurrenciesApi)
            self.otherCurrencies = otherCurrencies.map(OtherCurrenciesViewModel.init)
        } catch {
            print(error)
        }
        isLoading = false
    }
}

struct DollarViewModel {
    
    private var dollar: Currency
    init(dollar: Currency) {
        self.dollar = dollar
    }
    var nombre: String {
        dollar.nombre
    }
    var moneda: String {
        dollar.moneda
    }
    var compra: Double {
        dollar.compra
    }
    var venta: Double {
        dollar.venta
    }
    var fechaActualizacion: String {
        dollar.fechaActualizacion
    }
}

struct OtherCurrenciesViewModel {
    
    private var otherCurrencies: Currency
    init(otherCurrencies: Currency) {
        self.otherCurrencies = otherCurrencies
    }
    var nombre: String {
        otherCurrencies.nombre
    }
    var moneda: String {
        otherCurrencies.moneda
    }
    var compra: Double {
        otherCurrencies.compra
    }
    var venta: Double {
        otherCurrencies.venta
    }
    var fechaActualizacion: String {
        otherCurrencies.fechaActualizacion
    }
}
