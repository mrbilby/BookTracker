//
//  ContentView.swift
//  BookTracker
//
//  Created by James Bailey on 30/03/2023.
//

import SwiftUI

struct Book: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    let author: String
    let description: String
    var activity: String
    var review: String
    static let example = Book(title: "Example", author: "This is a test activity.", description: "test", activity: "Not Started", review: "0 stars")

    
}
class BookLib: ObservableObject {
    @Published var books: [Book] {
        didSet {
            if let encoded = try? JSONEncoder().encode(books) {
                UserDefaults.standard.set(encoded, forKey: "Books")
            }
        }
    }

    init() {

        if let saved = UserDefaults.standard.data(forKey: "Books") {
            if let decoded = try? JSONDecoder().decode([Book].self, from: saved) {
                books = decoded
                return
            }
        }

        books = []
    }
}

struct ContentView: View {
    @State private var showingNewBook = false

    @StateObject var data = BookLib()
    let sampleBook = Book(title: "bookName", author: "authorName", description: "description", activity: "Not Started", review: "0 stars")

    
    var body: some View {

        NavigationView {
            List(data.books) { item in
                NavigationLink {
                    BookDetail(data: data, item: item)
                } label: {
                    HStack {
                        Text(item.title).foregroundColor(item.review == "0 stars" ? .red : (item.review == "5 stars" ? .green : .blue))
                        Spacer()
                        Text(item.activity)
                    }
                    
                }
            }
            .navigationTitle("Book Tracker")
            .toolbar {
                Button {
                    showingNewBook = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingNewBook) {
                AddBook(data: data)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
