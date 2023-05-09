//
//  Platform.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/7.
//

import Foundation

enum Platform {
    case ios
    case android
    case web

    var displayText: String {
        switch self {
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .web:
            return "Web"
        }
    }
}
