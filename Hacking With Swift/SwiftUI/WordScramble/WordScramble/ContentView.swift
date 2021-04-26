//
//  ContentView.swift
//  WordScramble
//
//  Created by Hayden Davidson on 2/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorMessage = ""
    @State private var errorTitle = ""
    @State private var showingError = false
    @State private var score = 0
    
    
    
    
    var body: some View {
        //        Text("Hello world")
        NavigationView {
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                List(usedWords, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("Your score is: \(score)")
            }.navigationTitle(rootWord)
            .navigationBarItems(leading: Button("New Word", action: startGame))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if newWord.count < 3 || newWord == rootWord {
            return false
        }

        return misspelledRange.location == NSNotFound
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("There was an error loading start.txt from the bundle")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            score -= 1
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            score -= 1
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "that isn't a real word")
            score -= 1
            return
        }
        score += 1
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
