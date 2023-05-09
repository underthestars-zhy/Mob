//
//  MobbinPlatformSwitcher.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/7.
//

import SwiftUI

struct MobbinPlatformSwitcher: View {
    let largeTitle: Bool

    @Binding var platform: Platform

    @Binding var extend: Bool

    var body: some View {
        HStack(spacing: 0) {
            Text(extend ? "Platforms" : platform.displayText)
                .font(.system(size: largeTitle ? 42 : 26, weight: largeTitle ? .bold : .semibold))

            Image(systemName: "chevron.compact.down")
                .font(.system(size: largeTitle ? 24 : 16, weight: largeTitle ? .semibold : .medium))
                .rotationEffect(Angle(degrees: extend ? 180 : 0))
                .padding(.leading, 10)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                extend.toggle()
            }
        }
    }
}
