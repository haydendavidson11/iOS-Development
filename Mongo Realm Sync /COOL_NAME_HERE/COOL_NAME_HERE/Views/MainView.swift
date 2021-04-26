//
//  MainView.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 3/28/21.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    @EnvironmentObject var state: AppState
    
    @ObservedResults(Client.self) var clients
//    @ObservedResults(Job.self) var jobs
    
    var clientList: [Client] {
        var allClients = [Client]()
        for client in clients {
            allClients.append(client)
        }
        print(allClients.count)
        return allClients
    }
    
    
    var body: some View {
        TabView {
            if clients.count > 0  {
                ClientsView()
                    .tabItem { Image(systemName: "person.3")
                        Text("Clients")
                    }
                    .environment(\.realmConfiguration,
                                 app.currentUser!.configuration(partitionValue: "public=public"))
            } else {
                AnyView(ProgressView().onAppear {
                    $clients.append(Client())
                })
                .environment(\.realmConfiguration,
                             app.currentUser!.configuration(partitionValue: "public=public"))
            }
            
            if clients.count > 0 {
                
                JobsView(clients: $clients)
                    .tabItem { Image(systemName: "list.bullet.below.rectangle")
                        Text("Jobs")
                    }
                    .environment(\.realmConfiguration,
                                 app.currentUser!.configuration(partitionValue: "public=public"))
                    .environmentObject(state)
            } else {
                AnyView(ProgressView().onAppear {
                    clients[0].jobs.append(Job())
                })
                .environment(\.realmConfiguration,
                             app.currentUser!.configuration(partitionValue: "public=public"))
            }
            
            Text("\(state.user?._id ?? "")")
                .tabItem { Image(systemName: "person")
                    Text("Me")
                }
                .environment(\.realmConfiguration,
                             app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
        }
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
