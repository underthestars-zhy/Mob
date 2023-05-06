//
//  MobbinScreenButton.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/6.
//

import SwiftUI

struct MobbinScreenButton<Content: View>: View {
    let content: () -> Content
    let action: () -> ()

    var body: some View {
        MobbinButton {
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.black)
                .frame(height: 50)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.black, lineWidth: 3)
                }
                .overlay {
                    content()
                }
        } hoverView: {
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(Color(hexadecimal: "434343"))
                .frame(height: 50)
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color(hexadecimal: "434343"), lineWidth: 3)
                }
                .overlay {
                    content()
                }
        } action: {
            action()
        }
    }
}
