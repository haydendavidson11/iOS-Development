//
//  ContentView.swift
//  Moonshot
//
//  Created by Hayden Davidson on 2/17/21.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showCrew = false
    
    func getCrewMemebers(mission: Mission) -> String {
        var astronaut = [String]()
        for member in mission.crew {
            if let match =
                astronauts.first(where: {$0.id == member.name}) {
                astronaut.append(match.name)
            } else {
                fatalError("Missing \(member)")
            }
        }
        return astronaut.joined(separator: ",\n")
    }
    
   
    
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(showCrew ? mission.formattedLaunchDate : getCrewMemebers(mission: mission))
                            .font(.caption)
                    }
                }.navigationBarItems(trailing:
                                        Button(action: { showCrew.toggle()} , label: {Text(showCrew ? "Launch" : "Crew")}))
            }
            .navigationBarTitle("MoonShot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

