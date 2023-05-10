//
//  LoadingView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()

            CircleProgressView(lineWidth: 8)
                .frame(width: 40, height: 40)

            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
