//
//  DetailView.swift
//  BookWorm
//
//  Created by Hayden Davidson on 3/9/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                Text(self.book.review ?? "No review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Text("Date added: \(book.date ?? "No date recorded")")
                    .font(.footnote)
                    .padding()
                Spacer()
            }
        }.alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")){
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Test Author"
        book.rating = 4
        book.genre = "Fantasy"
        book.review = "This was a great book; I really enjoyed it."
        
       return NavigationView {
            DetailView(book: book)
        }
    }
}
