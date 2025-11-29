# HealthTrack Daily 🩺📱

HealthTrack Daily is a simple iOS health tracking app built with **SwiftUI**.

The goal is to help users log and visualize three key daily metrics:

- 🏃‍♂️ Steps  
- 🙂 Mood  
- 😴 Sleep (hours)

This project started as a learning path for moving from **React Native + Expo** to **native iOS with Swift + SwiftUI**.

---

## ✨ Features

- **Today Screen**
  - See today's steps, mood, and sleep at a glance
  - Clean summary cards with big, readable numbers
  - “Log Today” / “Edit Today” button

- **Log Entry**
  - Log steps with a slider
  - Pick mood (1–5) using emoji-based segmented control
  - Log sleep hours with a slider

- **History Screen**
  - See a list of previous days
  - Each row shows date, steps, mood, and sleep

---

## 🧱 Tech Stack

- **Language:** Swift
- **UI:** SwiftUI
- **Architecture:** Simple MVVM-style with `ObservableObject`
- **Platform:** iOS

---

## 🏗 Project Structure

- `HealthTrackDailyApp.swift`  
  App entry point, sets up `HealthStore` and root view.

- `DailyEntry.swift`  
  Data model representing a single day's health log.

- `HealthStore.swift`  
  `ObservableObject` that stores and manages all `DailyEntry` items.

- `RootView.swift`  
  Main `TabView` with **Today** and **History** tabs.

- `TodayView.swift`  
  Shows today's summary and button to log/edit.

- `LogEntryView.swift`  
  Form for logging steps, mood, and sleep.

- `HistoryView.swift`  
  List of all past entries.

---

## 🚀 Getting Started

### Prerequisites

- macOS
- [Xcode](https://developer.apple.com/xcode/) (latest version recommended)

### Running the app

1. Clone the repo:

   ```bash
   git clone https://github.com/<your-username>/HealthTrackDaily.git
   cd HealthTrackDaily

