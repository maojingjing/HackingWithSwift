//
//  ContentView.swift
//  iTour
//
//  Created by Jingjing Mao on 2/15/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    @State private var sortOder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    

    var body: some View {
        NavigationStack(path: $path) {
           DestinationListView(sort: sortOder, searchString: searchText)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDestination)
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOder) {
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))
                        
                        Text("Priority")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))
                        
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                        
                        
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
        
}

#Preview {
    ContentView()
}
