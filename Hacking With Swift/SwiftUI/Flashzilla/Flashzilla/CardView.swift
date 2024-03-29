//
//  CardView.swift
//  Flashzilla
//
//  Created by Hayden Davidson on 3/18/21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    let card: Card
    
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(differentiateWithoutColor ? Color.white : Color.white
                        .opacity(1 - Double(abs(offset.width / 50))))
                .background(differentiateWithoutColor ? nil : RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                .fill(offset.width > 0 ? Color.green : Color.red))
                .shadow(radius: 10)
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.prompt : card.answer)
                        .font(.largeTitle)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                }
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.secondary)
                }
                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(DragGesture()
                    .onChanged { offset in
                        self.offset = offset.translation
                        self.feedback.prepare()
                    }
                    .onEnded { _ in
                        if abs(self.offset.width) > 100 {
//                            remove the card
                            if self.offset.width > 0 {
                                self.feedback.notificationOccurred(.success)
                            } else {
                                self.feedback.notificationOccurred(.error)
                            }
                            
                            self.removal?()
                            
                        } else {
                            self.offset = .zero
                        }
                    }
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
