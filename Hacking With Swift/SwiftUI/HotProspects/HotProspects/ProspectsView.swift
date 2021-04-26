//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Hayden Davidson on 3/16/21.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum OrderType {
    case name, recent
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showingFilterSheet = false
    @State private var prospectOrder: OrderType = .recent
    
    let filter: FilterType
    
    let order: OrderType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter {
                $0.isContacted
            }
        case .uncontacted:
            return prospects.people.filter {
                !$0.isContacted
            }
        }
        
    }
    var sortedProspects: [Prospect] {
        if prospectOrder == .recent {
            return filteredProspects.reversed()
        } else {
            return filteredProspects.sorted(by: {$0.name < $1.name})
        }
    }
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        //         more code to come
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2  else {
                return
            }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.add(person)
            
        case .failure(let error):
            print("Scanning failed with: \(error)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            
            dateComponents.hour = 9
            //            triggers an alert at the next time matching 9am
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        //        More code to come
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(sortedProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                            
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                                self.prospects.toggle(prospect)
                            }
                            if !prospect.isContacted {
                                Button("Remind Me") {
                                    //                            set notification
                                    self.addNotification(for: prospect)
                                    
                                }
                            }
                        }))
                        if prospect.isContacted {
                            
                            Spacer()
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                            
                            
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(leading: Button(action: { self.showingFilterSheet = true},
                                                label: {Text("Sort")}),
                                trailing: Button(action: { self.isShowingScanner = true},
                                                 label: { Image(systemName: "qrCode.viewfinder")
                                                    Text("Scan")
                                                 }))
            .sheet(isPresented: $isShowingScanner){
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson/npaul@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Sort Prospects"), message: Text(""), buttons: [.default(Text("By Name")) {
                    //                    sort filteredProspects by name
                    prospectOrder = .name
                }, .default(Text("Most recent")) {
                    //                    sort fitleredProspects by most recently added
                    prospectOrder = .recent
                }])
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none, order: .recent)
    }
}
