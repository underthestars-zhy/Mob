//
//  TabStatus.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/12.
//

import Foundation

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
