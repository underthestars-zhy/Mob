//
//  MobbinPlatformPicker.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/9.
//

import SwiftUI

struct MobbinPlatformPicker: View {
    let largeTitle: Bool
    let platform: Platform
    @Binding var currentPlatform: Platform

    @EnvironmentObject var viewModel: NavigationViewModel

    var body: some View {
        Button {
            currentPlatform = platform

            withAnimation(.easeInOut) {
                viewModel.exntend = false
            }
        } label: {
            HStack(spacing: largeTitle ? 10 : 8) {
                Text(platform.displayText)
                    .font(.system(size: largeTitle ? 36 : 24, weight: largeTitle ? .semibold : .medium))
                    .foregroundColor(.black)

                Image(systemName: "arrow.right")
                    .font(.system(size: largeTitle ? 26 : 21, weight: largeTitle ? .medium : .regular))
                    .foregroundColor(.black)
            }
        }
    }
}
