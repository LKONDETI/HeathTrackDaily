
import SwiftUI

struct TodayView: View {
    @EnvironmentObject var healthStore: HealthStore
    @State private var isPresentingLog = false
    
    private var today: Date { Date() }
    
    private var todayEntry: DailyEntry? {
        healthStore.entry(for: today)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text(today, style: .date)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("Today")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Track your daily health in one place.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Summary cards
                if let entry = todayEntry {
                    TodaySummaryView(entry: entry)
                        .padding(.horizontal)
                } else {
                    VStack(spacing: 12) {
                        Text("No data for today yet")
                            .font(.headline)
                        Text("Tap the button below to log your steps, mood, and sleep.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Primary button
                Button {
                    isPresentingLog = true
                } label: {
                    Text(todayEntry == nil ? "Log Today" : "Edit Today")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .sheet(isPresented: $isPresentingLog) {
                LogEntryView(date: today)
            }
        }
    }
}


struct TodaySummaryView: View {
    let entry: DailyEntry
    
    var moodEmoji: String {
        switch entry.mood {
        case 1: return "☹️"
        case 2: return "😕"
        case 3: return "😐"
        case 4: return "🙂"
        default: return "😄"
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            MetricCardView(
                title: "Steps",
                value: "\(entry.steps)",
                subtitle: "Daily activity"
            )
            
            HStack(spacing: 16) {
                MetricCardView(
                    title: "Mood",
                    value: moodEmoji,
                    subtitle: "How you feel today"
                )
                
                MetricCardView(
                    title: "Sleep",
                    value: String(format: "%.1f h", entry.sleepHours),
                    subtitle: "Last night"
                )
            }
        }
    }
}

struct MetricCardView: View {
    let title: String
    let value: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(value)
                .font(.system(size: 28, weight: .bold))
            
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}
