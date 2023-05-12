//
//  TabBarItem.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/12.
//

import SwiftUI
import SwiftUIX

struct TabBarItem: View {
    let tab: TabStatus

    @Binding var current: TabStatus

    var body: some View {
        Button {
            current = tab
        } label: {
            VStack(spacing: 6) {
                Text(tab.displayText)
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(current == tab ? .white : Color(hexadecimal: "989898"))

                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 4)
                    .opacity(current == tab ? 1 : 0)
            }
            .animation(.easeInOut, value: current)
        }
    }
}
