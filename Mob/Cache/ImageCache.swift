//
//  ImageCache.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()

    var cache: [KeyValue] = []

    func push(_ image: Image, key: String) {
        guard !self.cache.map(\.key).contains(key) else { return }
        self.cache.append(KeyValue(key: key, value: image))
        clean()
    }

    func retrieve(key: String) -> Image? {
        cache.first { kv in
            kv.key == key
        }?.value
    }

    func clean() {
        while cache.count > 24 * 4 {
            cache.removeFirst()
        }
    }

    struct KeyValue {
        let key: String
        let value: Image
    }
}
