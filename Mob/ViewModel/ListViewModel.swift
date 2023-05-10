//
//  ListViewModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI
import MobbinAPI

class ListViewModel: ObservableObject {
    @Published var apps: [MobbinApp] = []

    func fetchApps(_ indicator: Indicator) {
        switch indicator.platform {
        case .ios:
            fetchApps(platform: .ios, indicator)
        case .android:
            fetchApps(platform: .android, indicator)
        case .web:
            fetchApps(platform: .web, indicator)
        }
    }

    func fetchApps(platform: Platform, _ indicator: Indicator) {
        switch indicator.section {
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
