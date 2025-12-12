
import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("Today")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
        }
    }
}
