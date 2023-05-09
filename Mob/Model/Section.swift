//
//  Section.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import Foundation

enum Section {
    case apps
    case screens
    case flows

    var displayText: String {
        switch self {
        case .apps:
            return "Apps"
        case .screens:
            return "Screens"
        case .flows:
            return "Flows"
        }
    }
}
