//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Hayden Davidson on 2/3/21.
//

import SwiftUI



struct ContentView: View {
    @State private var questionNumber = 1
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var isAnimated = false
    @State private var animationAmount = 0.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack{
                    Text("Tap the Flag of")
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer].uppercased())")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation(){
                            self.isAnimated = true
                        }
                        self.flagTapped(number)
                        
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                    .rotation3DEffect(
                        .degrees(number == self.correctAnswer && self.isAnimated ? 360 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                    .opacity(number != self.correctAnswer && self.isAnimated ? 0.25 : 1)
                }
                Text("Your Score is \(score)")
                    .foregroundColor(.white)
                Text("Question \(questionNumber) of 10")
                    .foregroundColor(.white)
                
                Spacer()
            }
            
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your Score is \(score)"), dismissButton: .default(Text("Continue")){
                askQuestion()
            })
        }
    }
    
    func animateFlag(){
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1

        }else{
            scoreTitle = "That is the flag of \(countries[number]) Try Again!"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion(){
        isAnimated = false
        questionNumber += 1
        isGameOver()
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func isGameOver(){
        if questionNumber == 11 {
            questionNumber = 1
            score = 0
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
        
    }
}
