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
            #if DEBUG
            if let userInfo, let token {
                return MobbinAPI(userInfo: userInfo, token: token)
            } else {
                let userInfo = UserInfo(id: "d2b41590-53a4-4c4d-9d94-06f5d71807c3", aud: "authenticated", role: "authenticated", email: "zhuhaoyu0909@icloud.com", emailConfirmedAt: Date(), recoverySentAt: Date(), lastSignInAt: Date(), avatarUrl: URL(string: "https://ujasntkfphywizsdaapi.supabase.co/storage/v1/object/public/user/user_avatars/a72e8064-f7eb-4b0a-841c-39a3a10dfca4.jpeg")!, fullName: "UTSzhy")
                let token = Token(accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjgzNjQ0ODY0LCJzdWIiOiJkMmI0MTU5MC01M2E0LTRjNGQtOWQ5NC0wNmY1ZDcxODA3YzMiLCJlbWFpbCI6InpodWhhb3l1MDkwOUBpY2xvdWQuY29tIiwicGhvbmUiOiIiLCJhcHBfbWV0YWRhdGEiOnsicHJvdmlkZXIiOiJlbWFpbCIsInByb3ZpZGVycyI6WyJlbWFpbCJdfSwidXNlcl9tZXRhZGF0YSI6eyJhdmF0YXJfdXJsIjoiaHR0cHM6Ly91amFzbnRrZnBoeXdpenNkYWFwaS5zdXBhYmFzZS5jby9zdG9yYWdlL3YxL29iamVjdC9wdWJsaWMvdXNlci91c2VyX2F2YXRhcnMvYTcyZTgwNjQtZjdlYi00YjBhLTg0MWMtMzlhM2ExMGRmY2E0LmpwZWciLCJmdWxsX25hbWUiOiJVVFN6aHkifSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJvdHAiLCJ0aW1lc3RhbXAiOjE2ODM1NTg0NjR9XSwic2Vzc2lvbl9pZCI6ImIyOGE0MDE1LThmMzgtNGU3OC05ZDg3LTBmOWFlNTlmMzRmOSJ9.v74vSVFk5AX_henUQ1EiEitMMa7M1s8ScucnADMJ5w0", refreshToken: "CcfvOuk9jphmerZziUIdnA")

                return MobbinAPI(userInfo: userInfo, token: token)
            }
            #else
            MobbinAPI(userInfo: userInfo!, token: token!)
            #endif
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
