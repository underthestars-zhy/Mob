//
//  ScrollDetector.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI

struct ScrollDetector: ViewModifier {
    @Binding var isScrolling: Bool
    @GestureState private var gestureState = MyGestureState.inactive

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($gestureState) { value, state, _ in
                        state = .active(translation: value.translation)
                    }
                    .onEnded { _ in
                        self.isScrolling = false
                    }
            )
            .onChange(of: gestureState) { value in
                if case .active = value {
                    self.isScrolling = true
                }
            }
    }
}

extension View {
    func detectScroll(isScrolling: Binding<Bool>) -> some View {
        self.modifier(ScrollDetector(isScrolling: isScrolling))
    }
}

enum MyGestureState: Equatable {
    case inactive
    case active(translation: CGSize)
}
