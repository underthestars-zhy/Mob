//
//  TabViewModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/12.
//

import SwiftUI

class TabViewModel: ObservableObject {
    @Published var currentTab: TabStatus = .browse
}
