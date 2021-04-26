//
//  EnvironmentObjectTechnique.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EnvironmentObjectTechnique: View {
    let user = User()
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    var body: some View {
        TextField("Name", text: $user.name)
            .border(Color.black)
            .padding()
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
     var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObjectTechnique_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectTechnique()
    }
}
