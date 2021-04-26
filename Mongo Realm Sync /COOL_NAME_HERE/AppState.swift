//
//  AppState.swift
//  COOL_NAME_HERE
//
//  Created by Hayden Davidson on 4/12/21.
//

import RealmSwift
import SwiftUI
import Combine


class AppState: ObservableObject {

    @Published var error: String?
    @Published var busyCount = 0
    
    var allClientsLoginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    var allClientsRealmPublisher = PassthroughSubject<Realm, Error>()
    
    var allJobsRealmPublisher = PassthroughSubject<Realm, Error>()
    var allJobsLoginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    
    var loginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    var logoutPublisher = PassthroughSubject<Void, Error>()
    var userRealmPublisher = PassthroughSubject<Realm, Error>()
    
    var cancellables = Set<AnyCancellable>()

    var shouldIndicateActivity: Bool {
        get {
            return busyCount > 0
        }
        set (newState) {
            if newState {
                busyCount += 1
            } else {
                if busyCount > 0 {
                    busyCount -= 1
                } else {
                    print("Attempted to decrement busyCount below 1")
                }
            }
        }
    }

    var user: User?
    
//    var allClientsRealm: Realm?
//    var allJobsRealm: Realm?

    var loggedIn: Bool {
        app.currentUser != nil && user != nil && app.currentUser?.state == .loggedIn
    }

    init() {
        _  = app.currentUser?.logOut()
        initLoginPublisher()
        initUserRealmPublisher()
        initLogoutPublisher()
//        initAllClientsRealmPublisher()
//        initAllClientsLoginPublisher()
        
//        initAllJobsRealmPublisher()
        
        
//        allClientsRealm = nil
//        allJobsRealm = nil
    }
    
//    func initAllJobsLoginPublisher() {
//        allJobsLoginPublisher
//            .receive(on: DispatchQueue.main)
//            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
//                self.shouldIndicateActivity = true
//                let realmConfig = user.configuration(partitionValue: "job=alljobs")
//
//                print(realmConfig)
//                return Realm.asyncOpen(configuration: realmConfig)
//            }
//            .receive(on: DispatchQueue.main)
//            .map {
//                return $0
//            }
//            .subscribe(allJobsRealmPublisher)
//            .store(in: &self.cancellables)
//    }
    
//    func initAllJobsRealmPublisher() {
//        allJobsRealmPublisher
//            .print()
//            .sink(receiveCompletion: { result in
//                if case let .failure(error) = result {
//                    self.error = "Failed to log in and open allJobs realm: \(error.localizedDescription)"
//                }
//            }, receiveValue: { realm in
//                print("allJobs Realm file location: \(realm.configuration.fileURL!.path)")
//
//            })
//            .store(in: &cancellables)
//    }
    
//    func initAllClientsLoginPublisher() {
//            allClientsLoginPublisher
//                .receive(on: DispatchQueue.main)
//                .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
//                    self.shouldIndicateActivity = true
//                    let realmConfig = user.configuration(partitionValue: "client=allclients")
//
//                    print(realmConfig)
//                    return Realm.asyncOpen(configuration: realmConfig)
//                }
//                .receive(on: DispatchQueue.main)
//                .map {
//                    return $0
//                }
//                .subscribe(allClientsRealmPublisher)
//                .store(in: &self.cancellables)
//        }
    
//    func initAllClientsRealmPublisher() {
//        allClientsRealmPublisher
//            .print()
//            .sink(receiveCompletion: { result in
//                if case let .failure(error) = result {
//                    self.error = "Failed to log in and open allClients realm: \(error.localizedDescription)"
//                }
//            }, receiveValue: { realm in
//                print("allClients Realm file location: \(realm.configuration.fileURL!.path)")
//                self.allClientsRealm = realm
//                self.shouldIndicateActivity = false
//            })
//            .store(in: &cancellables)
//    }
    
    func initLoginPublisher() {
        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
                self.shouldIndicateActivity = true
                let realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                print(user.id)
                print(realmConfig)
                return Realm.asyncOpen(configuration: realmConfig)
            }
            .receive(on: DispatchQueue.main)
            .map {
                return $0
            }
            .subscribe(userRealmPublisher)
            .store(in: &self.cancellables)
    }
    
    func initUserRealmPublisher() {
        userRealmPublisher
            .print()
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.error = "Failed to log in and open user realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("User Realm User file location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(User.self).first
                self.shouldIndicateActivity = false
            })
            .store(in: &cancellables)
    }
    
    func initLogoutPublisher() {
        logoutPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.user = nil
//                self.allClientsRealm = nil
//                self.allJobsRealm = nil
            })
            .store(in: &cancellables)
    }
    
}
