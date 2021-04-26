//
//  EditCards.swift
//  Flashzilla
//
//  Created by Hayden Davidson on 3/18/21.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    @State private var cards = [Card]()
    
  
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add a new card")) {
                    TextField("Promt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card") {
                        self.addCard()
                    }
                }
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(self.cards[index].prompt)
                                .font(.headline)
                            Text(self.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
//
                    }
                    .onDelete(perform: removeCards)
                }
            }
                .navigationTitle("Edit Cards")
                .navigationBarItems(trailing: Button(action: {
                   dismiss()
                }) {
                    Text("Done")
                })
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
        }
    }
    
    
    
    func dismiss() {
            presentationMode.wrappedValue.dismiss()
        }

        func loadData() {
            if let data = UserDefaults.standard.data(forKey: "Cards") {
                if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                    self.cards = decoded
                }
            }
        }

        func saveData() {
            if let data = try? JSONEncoder().encode(cards) {
                UserDefaults.standard.set(data, forKey: "Cards")
            }
        }
    
    func addCard() {
            let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
            let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
            guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

            let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
            cards.insert(card, at: 0)
            saveData()
           
        }

        func removeCards(at offsets: IndexSet) {
            cards.remove(atOffsets: offsets)
            saveData()
        }
    
}
    


struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
