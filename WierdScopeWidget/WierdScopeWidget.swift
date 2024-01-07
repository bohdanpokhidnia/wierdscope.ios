//
//  WierdScopeWidget.swift
//  WierdScopeWidget
//
//  Created by Bohdan Pokhidnia on 18.11.2023.
//

import WidgetKit
import SwiftUI
import SwiftData
import Firebase

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            foresight: "widget_placeholder".localize,
            fontSize: 16
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let fontSize = fontSize(for: context.family)
        let entry = SimpleEntry(
            date: Date(),
            foresight: "widget_placeholder".localize,
            fontSize: fontSize
        )
        completion(entry)
    }

    @MainActor func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        let fontSize = fontSize(for: context.family)
        let users = getUsers()
        let widgetFamily = context.family
        
        if users.isEmpty {
            let emptyTimeline = emptyTimeline(text: "widget_empty_sign".localize, for: widgetFamily)
            completion(emptyTimeline)
        } else {
            guard let user = users.first else {
                return
            }
            let today = Date.now.toString(for: .ddMMyyyy)
            let firestoreService = FirestoreService()
            
            Task {
                do {
                    let foresights = try await firestoreService.fetchItems(Foresight.self, from: .horoscope)
                    guard let foresight = foresights.first(where: {
                        $0.sign == user.sign && $0.date.contains(today)
                    }) else {
                        let emptyTimeline = emptyTimeline(text: "widget_empty_sign".localize, for: widgetFamily)
                        completion(emptyTimeline)
                        return
                    }
                    
                    let foresightEntry = SimpleEntry(
                        date: .now,
                        foresight: foresight.foresight.first ?? "empty foresight",
                        fontSize: fontSize
                    )
                    
                    let timeline = Timeline(entries: [foresightEntry], policy: .atEnd)
                    completion(timeline)
                } catch {
                    let emptyTimeline = emptyTimeline(text: error.localizedDescription, for: widgetFamily)
                    completion(emptyTimeline)
                    print("[dev] error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func emptyTimeline(text: String, for family: WidgetFamily) -> Timeline<Entry> {
        let fontSize = fontSize(for: family)
        let emptyEntry = SimpleEntry(
            date: .now,
            foresight: text,
            fontSize: fontSize
        )
        let timeline = Timeline(entries: [emptyEntry], policy: .atEnd)
        return timeline
    }
    
    @MainActor
    private func getUsers()-> [User]{
        guard let modelContainer = try? ModelContainer(for: User.self) else {
            return []
        }
        let descriptor = FetchDescriptor<User>()
        
        guard let users = try? modelContainer.mainContext.fetch(descriptor) else {
            return []
        }
        return users
    }
    
    private func fontSize(for family: WidgetFamily) -> CGFloat {
        switch family {
        case .systemSmall: 16
        case .systemMedium: 22
        case .systemLarge: 26
        default: 10
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let foresight: String
    let fontSize: CGFloat
}

struct WierdScopeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        MainTextItem(
            text: entry.foresight,
            size: entry.fontSize,
            isSecureText: false
        )
    }
}

struct WierdScopeWidget: Widget {
    let kind: String = "WierdScopeWidget"
    
    init() {
        FirebaseApp.configure()
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WierdScopeWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    Color.widgetBackground
                }
        }
        .configurationDisplayName("Wierd Scrope")
        .description("widget_description".localize)
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    WierdScopeWidget()
} timeline: {
    SimpleEntry(date: .now, foresight: "Capricorn is great", fontSize: 22)
}
