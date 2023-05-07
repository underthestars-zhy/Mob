//
//  MobbinManager.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/1.
//

import SwiftUI
import MobbinAPI

class MobbinManager {
    static let shared = MobbinManager()

    private var userInfo: UserInfo? = nil
    private var token: Token? = nil

    var mobbinAPI: MobbinAPI {
        get {
            MobbinAPI(userInfo: userInfo!, token: token!)
        }
    }

    enum _Token {
        static func convert(data: Data) throws -> Token {
            try JSONDecoder().decode(Token.self, from: data)
        }

        static func convert(token: Token) throws -> Data {
            try JSONEncoder().encode(token)
        }
    }

    enum _UserInfo {
        static func convert(data: Data) throws -> UserInfo {
            try JSONDecoder().decode(UserInfo.self, from: data)
        }

        static func convert(userInfo: UserInfo) throws -> Data {
            try JSONEncoder().encode(userInfo)
        }
    }

    func update() async throws {
        guard let userInfo, let token else { return }
        let mobbinAPI = MobbinAPI(userInfo: userInfo, token: token)
        try await mobbinAPI.refreshToken()

        let newToken = try mobbinAPI.retrieveToken()

        let tokenData = try MobbinManager._Token.convert(token: newToken)
        let userInfoData = try MobbinManager._UserInfo.convert(userInfo: userInfo)

        UserDefaults.standard.set(tokenData, forKey: "token")
        UserDefaults.standard.set(userInfoData, forKey: "userInfo")
    }

    func save() throws {
        guard let userInfo, let token else { return }

        let mobbinAPI = MobbinAPI(userInfo: userInfo, token: token)

        let newToken = try mobbinAPI.retrieveToken()

        let tokenData = try MobbinManager._Token.convert(token: newToken)
        let userInfoData = try MobbinManager._UserInfo.convert(userInfo: userInfo)

        UserDefaults.standard.set(tokenData, forKey: "token")
        UserDefaults.standard.set(userInfoData, forKey: "userInfo")
    }

    func save(userInfo: UserInfo, token: Token) throws {
        let tokenData = try MobbinManager._Token.convert(token: token)
        let userInfoData = try MobbinManager._UserInfo.convert(userInfo: userInfo)

        UserDefaults.standard.set(tokenData, forKey: "token")
        UserDefaults.standard.set(userInfoData, forKey: "userInfo")

        self.token = token
        self.userInfo = userInfo
    }

    func retrieve() async throws -> Bool {
        let tokenData = UserDefaults.standard.data(forKey: "token")
        let userInfoData = UserDefaults.standard.data(forKey: "userInfo")

        guard let tokenData, let userInfoData else { return false }

        let token = try Self._Token.convert(data: tokenData)
        let userInfo = try Self._UserInfo.convert(data: userInfoData)

        guard Date().timeIntervalSince1970 - token.generatedTime.timeIntervalSince1970 < 86400 else { return false }

        let mobbinAPI = MobbinAPI(userInfo: userInfo, token: token)
        try await mobbinAPI.refreshToken()

        let newToken = try mobbinAPI.retrieveToken()

        self.token = newToken
        self.userInfo = userInfo

        let newTokenData = try MobbinManager._Token.convert(token: newToken)

        UserDefaults.standard.set(newTokenData, forKey: "token")
        UserDefaults.standard.set(userInfoData, forKey: "userInfo")

        return true
    }

    func retrieveUserInfo() throws -> UserInfo? {
        let userInfoData = UserDefaults.standard.data(forKey: "userInfo")

        guard let userInfoData else { return nil }

        let userInfo = try Self._UserInfo.convert(data: userInfoData)

        return userInfo
    }
}
