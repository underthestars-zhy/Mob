//
//  AppListItem.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI
import MobbinAPI
import SwiftUIX

struct AppListItem: View {
    let app: MobbinApp
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                AsyncImage(url: app.appLogoUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72)
                } placeholder: {
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.15), x: 0, y: 0, blur: 10)

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(app.appName)
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .bold))

                        Text(app.appTagline)
                            .foregroundColor(Color(hexadecimal: "747474"))
                            .font(.system(size: 16, weight: .semibold))
                    }

                    Spacer()
                }

                Spacer()
            }

            HStack(spacing: 20) {
                ForEach(app.previewScreenUrls, id: \.self) { previewURL in
                    AsyncImage(url: previewURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: calPreviewWidth())
                    } placeholder: {
                        Color.white
                            .frame(width: calPreviewWidth(), height: calPreviewWidth() / 1125 * 2436)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hexadecimal: "E6E6E6"), lineWidth: 0.25)
                    }
                    .shadow(color: .black.opacity(0.05), x: 0, y: 2, blur: 8)
                }
            }
        }
    }

    func calPreviewWidth() -> Double {
        return Double(SwiftUIX.Screen.main.width - 80) / 3
    }
}
