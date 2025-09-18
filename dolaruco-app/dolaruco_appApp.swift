//
//  dolaruco_appApp.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 16.09.25.
//

import SwiftUI

@main
struct dolaruco_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ViewModel())
        }
    }
}
