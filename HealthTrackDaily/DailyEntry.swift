
import Foundation

struct DailyEntry: Identifiable {
    let id = UUID()
    let date: Date
    var steps: Int
    var mood: Int      // 1–5
    var sleepHours: Double
}
