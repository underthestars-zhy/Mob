//
//  MobbinButton.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/2.
//

import SwiftUI

struct MobbinButton<DefaultContent, HoverContent>: View where DefaultContent: View, HoverContent: View {
    let defaultView: DefaultContent
    let hoverView: HoverContent
    let action: () -> ()

    init(@ViewBuilder defaultView: () -> DefaultContent, @ViewBuilder hoverView: () -> HoverContent, action: @escaping () -> Void) {
        self.defaultView = defaultView()
        self.hoverView = hoverView()
        self.action = action
    }

    @State var hover = false

    var body: some View {
        ZStack {
            if hover {
                hoverView
            } else {
                defaultView
            }
        }
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                hover = true
            }
            .onEnded { _ in
                hover = false
                action()
            }
        )
        .onTouchDownGesture {
            hover = false
        }
    }
}
