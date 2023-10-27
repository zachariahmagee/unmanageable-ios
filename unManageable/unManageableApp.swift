//
//  unManageableApp.swift
//  unManageable
//
//  Created by Zachariah Magee on 10/25/23.
//

import SwiftUI
import SwiftData

@main
struct unManageableApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Reflection.self,
            BigBook.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Reflection.self, BigBook.self]) { result in
            do {
                let container = try result.get()
                
                // Check we haven't already added a reflection.
                let refDescriptor = FetchDescriptor<Reflection>()
                let existingReflections = try container.mainContext.fetchCount(refDescriptor)
                guard existingReflections == 0 else { return }
                
                // Load and decode the JSON.
                guard let url = Bundle.main.url(forResource: "dailyreflections", withExtension: "json") else {
                    fatalError("Failed to find dailyreflections.json")
                }
                
                let refData = try Data(contentsOf: url)
                let reflections = try JSONDecoder().decode([Reflection].self, from: refData)
                
                // Add all our data to the context.
                for reflection in reflections {
                    container.mainContext.insert(reflection)
                }
                
                let bbDescriptor = FetchDescriptor<BigBook>()
                let existingBigBook = try container.mainContext.fetchCount(bbDescriptor)
                guard existingBigBook == 0 else { return }
                
                guard let url = Bundle.main.url(forResource: "big_book_para", withExtension: "json") else {
                    fatalError("Failed to find big_book_para.json")
                }
                
                let bbData = try Data(contentsOf: url)
                let paragraphs = try JSONDecoder().decode([BigBook].self, from: bbData)
                
                for paragraph in paragraphs {
                    container.mainContext.insert(paragraph)
                }
                
                
            } catch {
                print("Failed to preseed database")
            }
        }
//        .modelContainer(for: BigBook.self) { result in
//            do {
//                let container = try result.get()
//                
//                let descriptor = FetchDescriptor<BigBook>()
//                let existingBigBook = try container.mainContext.fetchCount(descriptor)
//                guard existingBigBook == 0 else { return }
//                
//                guard let url = Bundle.main.url(forResource: "big_book_para", withExtension: "json") else {
//                    fatalError("Failed to find big_book_para.json")
//                }
//                
//                let data = try Data(contentsOf: url)
//                let paragraphs = try JSONDecoder().decode([BigBook].self, from: data)
//                
//                for paragraph in paragraphs {
//                    container.mainContext.insert(paragraph)
//                }
//            } catch {
//                print("")
//            }
//        }
     }
}
