//
//  MobAppModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/5.
//

import SwiftUI
import Combine

class MobAppModel: ObservableObject {
    @Published var logined = false

    private var subscribers: [AnyCancellable] = []

    init() {
        loginPublisher.sink { [weak self] value in
            self?.logined = value
        }
        .store(in: &subscribers)
    }

    func beInActive() {
        print("active")
        Task {
            logined = try await MobbinManager.shared.retrieve()
        }
    }

    func beInBackground() {
        do {
            print("background")
            try MobbinManager.shared.save()
            print("saved")
        } catch {
            print(error)
        }
    }

    func beInInactive() {
        print("inactive")
        Task {
            try await MobbinManager.shared.update()
            print("updated")
        }
    }
}
