//
//  MobApp.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/4/29.
//

import SwiftUI

@main
struct MobApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var appModel = MobAppModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appModel.logined {
                    ContentView()
                } else {
                    LoginView()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active:
                    appModel.beInActive()
                case .background:
                    appModel.beInBackground()
                case .inactive:
                    appModel.beInInactive()
                @unknown default:
                    print("unknow default")
                }
            }
        }
    }
}
