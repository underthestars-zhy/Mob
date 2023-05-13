//
//  MobbinAsyncImage.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/13.
//

import SwiftUI

struct MobbinAsyncImage<ImageView: View, PlaceholderView: View>: View {
    let url: URL

    @ViewBuilder let imageView: (Image) -> ImageView
    @ViewBuilder let placeholder: () -> PlaceholderView

    @State var imageData: Data? = nil

    var body: some View {
        if let image = ImageCache.shared.retrieve(key: url.path()) {
            imageView(image)
        } else if let data = KeyFileCache.shared.retrieve(key: url.path()), let image = Image(data: data) {
            imageView(image)
        } else {
            if let imageData, let image = Image(data: imageData) {
                imageView(image)
                    .onAppear {
                        ImageCache.shared.push(image, key: url.path())
                        KeyFileCache.shared.save(key: url.path(), file: imageData)
                    }
            } else {
                placeholder()
                    .task {
                        do {
                            let (data, response) = try await URLSession.shared.data(from: url)
                            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                                return
                            }
                            imageData = data
                        } catch is CancellationError {

                        } catch {
                            print(error)
                        }
                    }
            }
        }
    }
}
