
import SwiftUI

struct LogEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var healthStore: HealthStore
    
    let date: Date
    
    @State private var steps: Double = 5000
    @State private var mood: Int = 3
    @State private var sleepHours: Double = 7.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Activity") {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Steps")
                            Spacer()
                            Text("\(Int(steps))")
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $steps, in: 0...20000, step: 500)
                    }
                }
                
                Section("Mood") {
                    Picker("Mood", selection: $mood) {
                        Text("☹️ 1").tag(1)
                        Text("😕 2").tag(2)
                        Text("😐 3").tag(3)
                        Text("🙂 4").tag(4)
                        Text("😄 5").tag(5)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Sleep") {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Hours")
                            Spacer()
                            Text(String(format: "%.1f", sleepHours))
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $sleepHours, in: 0...12, step: 0.5)
                    }
                }
            }
            .navigationTitle("Log Today")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let entry = DailyEntry(
                            date: date,
                            steps: Int(steps),
                            mood: mood,
                            sleepHours: sleepHours
                        )
                        healthStore.addOrUpdate(entry: entry)
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let existing = healthStore.entry(for: date) {
                    steps = Double(existing.steps)
                    mood = existing.mood
                    sleepHours = existing.sleepHours
                }
            }
        }
    }
}
