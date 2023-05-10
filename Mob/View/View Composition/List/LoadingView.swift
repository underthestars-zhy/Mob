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
            CircleProgressView(lineWidth: 8)
                .frame(width: 40, height: 40)
                .padding(.top, 50)
        }
        .frame(maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
