//
//  LoginViewModel.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/2.
//

import SwiftUI
import MobbinAPI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""

    @Published var emailSent = false

    @Published var status = Status.nothing

    var mobbinAPI: MobbinAPI?

    func sendEmail() {
        guard !email.isEmpty else { return }
        mobbinAPI = .init(email: email)
        Task {
            emailSent = true
            do {
                try await mobbinAPI?.sendEmail()
                print("email have sent")
            } catch {
                print(error)
                emailSent = false
            }
        }
    }

    func verifyCode() {
        guard let mobbinAPI else { return }
        guard !code.isEmpty else { return }
        status = .verify
        Task {
            print("check code")
            do {
                if try await mobbinAPI.verify(code: code) {
                    print("verify code is right")
                    try MobbinManager.shared.save(userInfo: try mobbinAPI.retrieveUserInfo(), token: try mobbinAPI.retrieveToken())
                    status = .success
                    try await Task.sleep(for: .seconds(0.6))
                    loginPublisher.send(true)
                } else {
                    print("wrong code")
                    status = .nothing
                }
            } catch {
                print(error)
                status = .nothing
            }
        }
    }

    enum Status {
        case nothing
        case verify
        case success
    }
}
