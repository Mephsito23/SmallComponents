//
//  Test.swift
//  Test
//
//  Created by Mephisto on 2022/3/8.
//

import Intents
import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    private func randomEntry(_ date: Date = Date()) -> SimpleEntry {
        SimpleEntry(date: date, saying: SayingManager.share.randomSaying)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        randomEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(randomEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for minOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minOffset + 30, to: currentDate)!
            let entry = randomEntry(entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let saying: Saying
}

struct TestEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            Image("flower5")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 120)
            VStack(alignment: .leading, spacing: 10) {
                Text("To be both a speaker of words and a doer of deeds.")
                    .font(.system(size: 18))
                Text("既当演说家，又做实干家")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

@main
struct Test: Widget {
    let kind: String = "Test"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TestEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        TestEntryView(entry: SimpleEntry(date: Date(), saying: SayingManager.share.randomSaying))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
