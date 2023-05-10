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
}
