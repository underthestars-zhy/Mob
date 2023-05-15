//
//  NavigationViewModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI
import Combine

class NavigationViewModel: ObservableObject {
    @Published var platform: Platform = .ios

    @Published var exntend = false // Choose the platform
    @Published var stage = Stage.normal 
    @Published var currentSection: Section = .apps

    var uikitScrollView: UIScrollView? = nil

    private var subscribers: [AnyCancellable] = []

    init() {
        $platform
            .sink { newValue in
                Indicator.shared.platform = newValue
            }
            .store(in: &subscribers)

        $currentSection
            .sink { newValue in
                Indicator.shared.section = newValue
            }
            .store(in: &subscribers)

        $exntend
            .sink { [weak self] newVluae in
                if newVluae && (self?.stage ?? .normal) == .normal {
                    selectPlatformPublisher.value = true
                } else {
                    selectPlatformPublisher.value = false
                }
            }
            .store(in: &subscribers)
    }
    

    enum Stage {
        case normal
        case smallHead
        case minimal
    }
}
