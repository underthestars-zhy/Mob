//
//  CircleProgressView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/6.
//

import SwiftUI

struct CircleProgressView: View {
    @State var rotate = false
    var body: some View {
        Circle()
            .trim(from: 0, to: 3/4)
            .rotation(Angle(degrees: rotate ? 360 : 0))
            .stroke(Color(hexadecimal: "151515"), style: StrokeStyle(lineWidth: 4, lineCap: .round))
            .foregroundColor(.clear)
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: rotate)
            .onAppear {
                rotate = true
            }
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView()
            .padding()
    }
}
