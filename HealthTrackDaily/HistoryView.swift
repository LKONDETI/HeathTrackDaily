//
//  HistoryView.swift
//  HealthTrackDaily
//
//  Created by Lakshmi Kondeti on 11/28/25.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var healthStore: HealthStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(healthStore.entries) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.date, style: .date)
                            .font(.headline)
                        
                        HStack {
                            Label("\(entry.steps)", systemImage: "figure.walk")
                            Spacer()
                            Label("\(entry.mood)", systemImage: "face.smiling")
                            Spacer()
                            Label(String(format: "%.1f h", entry.sleepHours), systemImage: "bed.double.fill")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("History")
        }
    }
}
