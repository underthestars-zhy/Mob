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
            withAnimation(.easeInOut) {
                currentPlatform = platform
                viewModel.exntend = false
            }
        } label: {
            HStack(spacing: 10) {
                Text(platform.displayText)
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(.black)

                Image(systemName: "arrow.right")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
}
