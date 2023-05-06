//
//  MobbinTextButton.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/2.
//

import SwiftUI

struct MobbinTextButton: View {
    let text: String
    let action: () -> ()

    var body: some View {
        MobbinScreenButton {
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
        } action: {
            action()
        }
    }
}

struct MobbinTextButton_Previews: PreviewProvider {
    static var previews: some View {
        MobbinTextButton(text: "Continue with email") {

        }
        .padding()
    }
}
