//
//  ContentView.swift
//  unManageable
//
//  Created by Zachariah Magee on 10/25/23.
//

import SwiftUI
import SwiftData
import Foundation



struct NavigationItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var icon: String
//    var menu: Menu
}


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var reflections: [Reflection]
    @Query private var paragraphs: [BigBook]
    
//    var collections: [Collection] = [
//        .init(title: "Daily Reflections", imageName: "calendar", readings: reflections)
//    ]

    @State private var path : [String] = []

    var body: some View {
        
        NavigationStack {
            VStack {
                Text("unManageable")
                    .font(.largeTitle.bold())

                Spacer()
                
//                Section("Readings") {
                
                    List {
                        
                        Section("Readings") {
                            NavigationLink {
                                ReflectionView()
                            } label: {
                                VStack {
                                    Label("Daily Reflections", systemImage: "calendar")
        //                            Spacer()
                                }
                            }
                            NavigationLink {
                                BigBookView()
                            } label: {
                                VStack {
                                    Label("Big Book", systemImage: "book.pages")
                                    Spacer()
                                }
                            }
                        }
                    }
//                }
            }
        }
    }
}

struct ReflectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var reflections: [Reflection]
    
//    @State private var path : [any View] = []
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(reflections.sorted {$0.getOrder() < $1.getOrder()}) { reflection in
                    NavigationLink {
                        VStack {
                            Text("\(reflection.month.lowercased().capitalized) \(reflection.day): \(reflection.title.lowercased().capitalized)")
                            Text("\(reflection.quotation)")
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("\(reflection.reading)")
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("\(reflection.citation.lowercased().capitalized)")
                                .padding()
                        }
                        
                    } label: {
                        Text("\(reflection.month.lowercased().capitalized) \(reflection.day): \(reflection.title.lowercased().capitalized)")
                    }
                }
            }
        }
    }
}

struct BigBookView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var paragraphs: [BigBook]
    
    var body: some View {

        VStack {
            List {
                ForEach(paragraphs.sorted { $0.getOrder() < $1.getOrder() }) { paragraph in
                    NavigationLink {
                        VStack {
                            Text("\(paragraph.title)")
                                .font(.title.bold())
                            Text("\(paragraph.body)")
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    } label: {
                        Text("\(paragraph.title): \(paragraph.paragraph)")
                    }
                }
            }
        }
    }
}




#Preview {
    ContentView()
        .modelContainer(for: Reflection.self, inMemory: true)
}


class Collection<T>: Hashable {
    let title: String
    let imageName: String
    let readings: [T]
    
    init(title: String, imageName: String, readings: [T]) {
        self.title = title
        self.imageName = imageName
        self.readings = readings
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func ==(lhs: Collection, rhs: Collection) -> Bool {
        return lhs.title == rhs.title && lhs.title == rhs.title
    }
}
