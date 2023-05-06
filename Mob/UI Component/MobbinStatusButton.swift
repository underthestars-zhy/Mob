//
//  MobbinStatusButton.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/6.
//

import SwiftUI

struct MobbinStatusButton<Content: View>: View {
    let content: () -> Content

    var body: some View {
        RoundedRectangle(cornerRadius: 18)
            .foregroundColor(Color(hexadecimal: "EDEDED"))
            .frame(height: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(hexadecimal: "EDEDED"), lineWidth: 3)
            }
            .overlay {
                content()
            }
    }
}
