//
//  MidnightWorksTestAppApp.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 01.10.2021.
//

import SwiftUI

@main
struct MidnightWorksTestAppApp: App {
    
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.mainViewModel)
        }
    }
}
