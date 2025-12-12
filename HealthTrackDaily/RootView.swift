
import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: AuthManager

    var body: some View {
        TabView {
            TodayView()
                .tabItem { Image(systemName: "sun.max.fill"); Text("Today") }
            HistoryView()
                .tabItem { Image(systemName: "clock.fill"); Text("History") }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Log out") {
                    auth.signOut()
                }
            }
        }
    }
}
