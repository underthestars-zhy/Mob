//
//  MobbinPlatformSwitcher.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/7.
//

import SwiftUI

struct MobbinPlatformSwitcher: View {
    @EnvironmentObject var viewModel: NavigationViewModel

    let largeTitle: Bool

    @Binding var platform: Platform

    @Binding var extend: Bool

    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                extend.toggle()
            }
        } label: {
            HStack(spacing: 0) {
                Text(extend ? (viewModel.stage == .normal ? "Platforms" : viewModel.platform.displayText) : platform.displayText)
                    .font(.system(size: largeTitle ? 42 : 26, weight: largeTitle ? .bold : .semibold))
                    .foregroundColor(.black)

                Image(systemName: "chevron.compact.down")
                    .font(.system(size: largeTitle ? 24 : 16, weight: largeTitle ? .semibold : .medium))
                    .rotationEffect(Angle(degrees: extend ? 180 : 0))
                    .padding(.leading, 10)
                    .foregroundColor(.black)
            }
        }
    }
}
