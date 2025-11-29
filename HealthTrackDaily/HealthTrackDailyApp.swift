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
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(healthStore)
        }
    }
}
