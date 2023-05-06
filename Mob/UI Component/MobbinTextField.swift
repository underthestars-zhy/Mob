//
//  MobbinTextField.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/1.
//

import SwiftUI
import SwiftUIX

struct MobbinTextField: View {
    let prompt: String
    @Binding var text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color(hexadecimal: "E0E0E0"), lineWidth: 3)
            .frame(height: 40)
            .overlay {
                HStack {
                    TextField(text: $text) {
                        Text(prompt)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 15)
                }
            }
    }
}

struct MobbinTextField_Previews: PreviewProvider {
    static var previews: some View {
        MobbinTextField(prompt: "Enter email adress",text: .constant(""))
            .padding()
    }
}
