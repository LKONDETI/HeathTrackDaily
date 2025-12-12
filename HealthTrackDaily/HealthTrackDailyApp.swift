import SwiftUI

@main
struct HealthTrackDailyApp: App {
    @StateObject private var healthStore = HealthStore()
    @ObservedObject private var auth = AuthManager.shared

    init() {
        // Called when the app launches
        auth.configureOnLaunch()
    }

    var body: some Scene {
        WindowGroup {
            if auth.isSignedIn {
                RootView()
                    .environmentObject(healthStore)
                    .environmentObject(auth) // optional if some views need it
            } else {
                NavigationStack {
                    SignInWithAppleView()
                        .navigationTitle("Sign in")
                }
            }
        }
    }
}

