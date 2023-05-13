//
//  MobAppModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/5.
//

import SwiftUI
import Combine

class MobAppModel: ObservableObject {
    @Published var logined: Bool? = nil

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
            do {
                let res = try await MobbinManager.shared.retrieve()
                logined = res
            } catch {
                logined = false
                print(error)
            }
        }
    }

    func beInBackground() {
//        do {
//            print("background")
//            try MobbinManager.shared.save()
//            print("saved")
//        } catch {
//            print(error)
//        }
    }

    func beInInactive() {
        print("inactive")
        Task {
            do {
                try await MobbinManager.shared.update()
                print("updated")
            } catch {
                print(error)
            }
        }
    }
}
