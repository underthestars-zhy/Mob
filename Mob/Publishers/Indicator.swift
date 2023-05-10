//
//  Indicator.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI

class Indicator: ObservableObject {
    static let shared = Indicator()

    @Published var platform: Platform = .ios
    @Published var section: Section = .apps
    
}
