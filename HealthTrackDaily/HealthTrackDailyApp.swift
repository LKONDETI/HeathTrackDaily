//
//  HealthTrackDailyApp.swift
//  HealthTrackDaily
//
//  Created by Lakshmi Kondeti on 11/28/25.
//

import SwiftUI

@main
struct HealthTrackDailyApp: App {
    @StateObject private var healthStore = HealthStore()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                RootView()
                    .environmentObject(healthStore)
            } else {
                AuthContainerView()
            }
        }
    }
}
