//
//  AddBook.swift
//  BookTracker
//
//  Created by James Bailey on 30/03/2023.
//

import SwiftUI



struct AddBook: View {
    @Environment(\.dismiss) var dismiss
    @State private var bookName = ""
    @State private var authorName = ""
    @State private var description = ""
    @State private var activity = "Not Started"
    @State private var review = "0 stars"
    @ObservedObject var data: BookLib

    public var item = Book(title: "", author: "", description: "", activity: "", review: "")
    var body: some View {
        NavigationView {
            Form {
                TextField("Book name", text: $bookName)
                TextField("Author name", text: $authorName)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add new book")
            .toolbar {
                Button("Save") {
                    let sampleBook = Book(title: bookName, author: authorName, description: description, activity: "Not Started", review: "0 stars")
                    data.books.append(sampleBook)
                    dismiss()
                }
                
            }
        }
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook(data: BookLib())
    }
}
