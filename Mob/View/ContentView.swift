//
//  ContentView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/4/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MobbinNavigationView { indicator in
            switch indicator.platform {
            case .ios:
                iOSListView(indicator: indicator)
            case .android:
                EmptyView()
            case .web:
                EmptyView()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}