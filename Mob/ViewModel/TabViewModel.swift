//
//  TabViewModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/12.
//

import SwiftUI
import Combine

class TabViewModel: ObservableObject {
    @Published var currentTab: TabStatus = .browse
    @Published var tabBarStage = TabBarStage.normal

    private var subscribers: [AnyCancellable] = []

    enum TabBarStage {
        case normal
        case ignore
    }

    enum TabStatus {
        case browse
        case collections

        var displayText: String {
            switch self {
            case .browse:
                return "Browse"
            case .collections:
                return "Collections"
            }
        }
    }


    init() {
        selectPlatformPublisher
            .sink { [weak self] bool in
                self?.tabBarStage = bool ? .ignore : .normal
            }
            .store(in: &subscribers)
    }
}
