//
//  Card.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/28/21.
//

import SwiftUI
import RealmSwift

struct CardView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var publicRealm
    @Environment(\.presentationMode) var presentationMode
    
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var labelColor = Color.blue
    @State private var showMaterials = false
    
    @StateRealmObject var client: Client
//    @ObservedRealmObject var client: Client
//   var client: Client
    
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [labelColor, Color.white]), startPoint: .top, endPoint: .bottom))
                .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .shadow(radius: 5)
            ScrollView {
                VStack{
                    HStack{
                        Text("Neighborhood")
                        Spacer()
                        Text(client.categoryState.asString)
                            .padding()
                            .background(Color.white
                                            .opacity(0.3))
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                            .contextMenu(ContextMenu(menuItems: {
                                Button("Needs Estimate") {
//                                    publicRealm.beginWrite()
                                    client.categoryState = .needsEstimate
                                    labelColor = Color.blue
                                }
                                Button("Estimate Pending") {
                                    client.categoryState = .estimatePending
                                    try! publicRealm.commitWrite()
                                    labelColor = Color.red
                                }
                                Button("To be Scheduled") {
                                    publicRealm.beginWrite()
                                    client.categoryState = .toBeScheduled
                                    try! publicRealm.commitWrite()
                                    labelColor = Color.yellow
                                }
                                Button("Scheduled") {
                                    publicRealm.beginWrite()
                                    client.categoryState = .scheduled
                                    try! publicRealm.commitWrite()
                                    labelColor = Color.green
                                }
                                Button("Complete") {
                                    publicRealm.beginWrite()
                                    client.categoryState = .complete
                                    try! publicRealm.commitWrite()
                                    labelColor = Color.orange
                                }
                                
                            }))
                    }
                    .padding()
                    ContactView(client: client)
                    Divider()
                    CommentView()
                    
                }
            }
            
        }
        .animation(.spring())
        .frame(width: 325, height: 525)
        .offset(x: offset.width , y: 0)
    }
    
    
}



//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: Card.exampleJob)
//    }
//}
//MARK: - Contact View

struct ContactView: View {
    
    
    let client: Client
    
    var body: some View {
        VStack(alignment: .leading) {
            
            
            Text("\(client.firstName.capitalized) \(client.lastName.capitalized)")
                .font(.largeTitle)
            Divider()
            
            
            HStack {
                Image(systemName: "envelope")
                Text(client.email)
            }
            .padding(.top)
            HStack {
                Image(systemName: "phone")
                Text(client.phoneNumber)
            }
            .padding(.top)
            AddressView(address: client.address ?? Address())
                .padding(.top)
            
            
            
            
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

//MARK: - CommentView

struct CommentView: View {
    @State private var commentMessage = ""
    @State private var comments = [Comment]()
    @State private var showComments = false
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "text.bubble")
                Text("Show Comments")
                Spacer()
                Toggle("show comments", isOn: $showComments)
                    .labelsHidden()
            }
            .padding([.leading, .trailing])
            HStack {
                TextField("Add Comment...", text: $commentMessage)
                
                Spacer()
                Button("Add") {
                    
                    let formatter = DateFormatter()
                    
                    formatter.timeStyle = .short
                    formatter.dateStyle = .short
                    
                    let dateString = formatter.string(from: Date())
                    
                    let newComment = Comment(message: commentMessage, user: app.currentUser!.id, postDate: dateString)
                    
                    comments.insert(newComment, at: 0)
                    commentMessage = ""
                    
                    hideKeyboard()
                    
                }.foregroundColor(.primary)
            }
            .padding([.leading, .trailing])
            
            if showComments {
                
                ForEach(comments, id: \.id) { comment in
                    HStack(alignment: .firstTextBaseline) {
//                        comment.user?.userPreferences?.avatarImage?
                        VStack(alignment: .leading) {
                            Text(comment.message ?? "NO COMMENT")
                            Text(comment.postDate ?? "")
                                    .font(.footnote)
                                    .padding()
                        }
                        Spacer()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .padding()
            }
            
            
        }
        
        
    }
    
    
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
