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

    enum Stage {
        case normal
        case smallHead
        case minimal
    }
}
