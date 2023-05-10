//
//  ListViewModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI
import MobbinAPI
import Combine

class ListViewModel: ObservableObject {
    @Published var apps: [MobbinApp] = []

    func fetchApps() {
        apps = []
        
        switch Indicator.shared.platform {
        case .ios:
            fetchApps(platform: .ios)
        case .android:
            fetchApps(platform: .android)
        case .web:
            fetchApps(platform: .web)
        }
    }

    func fetchApps(platform: Platform) {
        print("loading \(Indicator.shared.platform) : \(Indicator.shared.section)")

        switch Indicator.shared.section {
        case .apps:
            Task {
                apps = try await MobbinManager.shared.mobbinAPI.queryNextPage(nil)
            }
        case .screens:
            break
        case .flows:
            break
        }
    }
}
