//
//  KeyFileCache.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/13.
//

import Foundation

class KeyFileCache {
    static let shared = KeyFileCache()

    var fileBase: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func save(key: String, file: Data) {
        let key = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? key

        let url = fileBase.appending(path: key)

        guard !FileManager.default.fileExists(atPath: url.path()) else { return }

        FileManager.default.createFile(atPath: url.path(), contents: file)
    }

    func retrieve(key: String) -> Data? {
        let key = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? key

        let url = fileBase.appending(path: key)

        guard FileManager.default.fileExists(atPath: url.path()) else { return nil }

        return try? Data(contentsOf: url)
    }
}
