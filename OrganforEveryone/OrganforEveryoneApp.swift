//
//  OrganforEveryoneApp.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/6.
//

import SwiftUI

@main
struct OrganforEveryoneApp: App {
    let organModel = OrganModel()
    let appModel = AppModel()
    let locationManager = LocationManager()
        @Environment(\.scenePhase) private var scenePhase
        
        var body: some Scene {
            WindowGroup {
                ContentView()
                   // .environmentObject(organModel)
                    .environmentObject(appModel)
                    .environmentObject(locationManager)
            }
//            .onChange(of: scenePhase){phase in
//                switch phase{
//                case .inactive:
//                    locationManager.saveData()
//                default:
//                    break
//                }
//            }
        }
}
