//
//  BookDetail.swift
//  BookTracker
//
//  Created by James Bailey on 01/04/2023.
//

import SwiftUI

struct BookDetail: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var data: BookLib
    let choices = ["Not Started", "Reading Now", "Finished", "DNF"]
    let reviewOptions = ["5 stars", "4 stars", "3 stars", "1 star", "0 stars"]
    var item: Book
    @State private var choice = "Finished"
    @State private var reviewChoice = "5 stars"

    var body: some View {
            List {
                Section {
                    if item.description.isEmpty == false {
                        Text(item.title)
                    }
                }

                Section {
                    Menu {
                        ForEach(["Not Started", "Reading Now", "Finished", "DNF"], id: \.self) { option in
                            Button("Currently \(option)") {
                                choice = option
                                var newItem = item
                                newItem.activity = choice
                                if let index = data.books.firstIndex(of: item) {
                                    data.books[index] = newItem
                                }
                            }
                        }
                    } label: {
                        Label("Currently \(item.activity)", systemImage: "chevron.right")
                    }
                    /*
                    Picker(item.activity, selection: $choice) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                        }
                    }
                    */
                    Menu {
                        ForEach(["5 stars", "4 stars", "3 stars", "1 star", "0 stars"], id: \.self) { option in
                            Button("Currently \(option)") {
                                reviewChoice = option
                                var newItem = item
                                newItem.review = reviewChoice
                                if let index = data.books.firstIndex(of: item) {
                                    data.books[index] = newItem
                                }
                            }
                        }
                    } label: {
                        Label("Currently \(item.review)", systemImage: "chevron.right")
                    }
                    /*
                    Picker(item.review, selection: $reviewChoice) {
                        ForEach(reviewOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    Button("Mark Completed") {
                        var newItem = item
                        newItem.activity = choice
                        newItem.review = reviewChoice
                        if let index = data.books.firstIndex(of: item) {
                            data.books[index] = newItem
                        }
                        dismiss()
                    }
                     */
                }
            }
            .navigationTitle(item.title)
        }
}

/*
struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(data: BookLib(), item: <#Book#>)
        
    }
}
*/

