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

    var lastApp: MobbinApp? = nil
    var loading = false

    func fetchApps() {
        apps = []
        lastApp = nil
        
        updateApps()
    }

    func updateApps() {
        guard !loading else { return }

        print("loading \(Indicator.shared.platform) : \(Indicator.shared.section)")

        switch Indicator.shared.platform {
        case .ios:
            switch Indicator.shared.section {
            case .apps:
                Task {
                    loading = true
                    apps += try await MobbinManager.shared.mobbinAPI.queryNextPage(lastApp)
                    lastApp = apps.last
                    loading = false
                }
            case .flows:
                break
            case .screens:
                break
            }
        case .android:
            break
        case .web:
            break
        }
    }
}
