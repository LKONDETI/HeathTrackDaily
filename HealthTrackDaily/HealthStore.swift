
import Foundation
import Combine

class HealthStore: ObservableObject {
    @Published var entries: [DailyEntry] = []
    
    init() {
        // Optional: add some mock data so History isn't empty initially
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        
        entries = [
            DailyEntry(date: today, steps: 6500, mood: 4, sleepHours: 7.5),
            DailyEntry(date: yesterday, steps: 8200, mood: 5, sleepHours: 8.0),
            DailyEntry(date: twoDaysAgo, steps: 4000, mood: 2, sleepHours: 5.5)
        ]
    }
    
    func addOrUpdate(entry: DailyEntry) {
        if let index = entries.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: entry.date) }) {
            entries[index] = entry
        } else {
            entries.append(entry)
        }
        entries.sort { $0.date > $1.date }
    }
    
    func entry(for date: Date) -> DailyEntry? {
        entries.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}
