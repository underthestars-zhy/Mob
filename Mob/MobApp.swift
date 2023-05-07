//
//  MobApp.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/4/29.
//

import SwiftUI
import SwiftUIX

@main
struct MobApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var appModel = MobAppModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let login = appModel.logined {
                    if login {
                        ContentView()
                    } else {
                        LoginView()
                    }
                } else {
                    Image("Launch Screen")
                        .scaledToFit()
                        .frame(width: Screen.main.width)
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
