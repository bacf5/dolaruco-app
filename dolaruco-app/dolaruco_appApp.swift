//
//  dolaruco_appApp.swift
//  dolaruco-app
//
//  Created by Bruno Agustin Caruso Fassa on 16.09.25.
//

import SwiftUI
import Combine

@main
struct dolaruco_appApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ViewModel())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    var dollarListVM: ViewModel!
    
    @MainActor
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // init the viewModel - so everytime that the is shown, a new redraw of dollarucos is loaded
        self.dollarListVM = ViewModel()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "dollarsign.bank.building", accessibilityDescription: "Dollar Sign")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 500, height: 450)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(vm: self.dollarListVM))
        
        
        
    }
    
    @objc func togglePopover() {
        
        Task {
            await self.dollarListVM.populateDollars()
        }
        
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
}
