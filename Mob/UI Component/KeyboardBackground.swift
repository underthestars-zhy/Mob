//
//  KeyboardBackground.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/9.
//

import SwiftUI

struct KeyboardBackground<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.white
                .onTapGesture {
                    self.endEditing()
                }
                .maxWidth(.infinity)
                .maxHeight(.infinity)

            content
        }
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct KeyboardBackground_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardBackground {

        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
