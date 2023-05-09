//
//  ScrollOffset.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI


struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

struct ScrollOffsetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear
                .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
        })

    }
}

extension View {
    func measureScroll(perform action: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(ScrollOffsetModifier())
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}
