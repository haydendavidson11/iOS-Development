//
//  AddBookView.swift
//  BookWorm
//
//  Created by Hayden Davidson on 3/9/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                Section {
                    Button("Save") {
//                        Add the book
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                        let dateString = formatter.string(from: Date())
                        
                        let newBook = Book(context: self.moc)
                        
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre.isEmpty ? "Unknown Genre" : self.genre
                        newBook.review = self.review
                        newBook.date = dateString
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }.disabled(validBook())
                }
            }.navigationBarTitle("Add Book")
        }
    }
    
    func validBook() -> Bool {
        if title.isEmpty || author.isEmpty || genre.isEmpty {
            return true
        }
        return false
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
