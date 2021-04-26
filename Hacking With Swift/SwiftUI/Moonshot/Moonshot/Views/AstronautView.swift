//
//  AstronautView.swift
//  Moonshot
//
//  Created by Hayden Davidson on 2/18/21.
//

import SwiftUI



struct AstronautView: View {
    
    let allMissions: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: Astronaut
    
    
    var body: some View {
        
        let onMissions: [Mission] = allMissions.filter { mission in
            mission.crew.contains(where: {$0.name == self.astronaut.id})
        }
        
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width)
                    HStack(alignment: .center){
                        ForEach(onMissions) {
                            mission in
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100, alignment: .center)
                                .padding()
                        }
                    }
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}


struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] =
        Bundle.main.decode("astronauts.json")
    
    static let missions: [Mission] =
        Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
