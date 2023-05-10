//
//  ContentView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/4/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var indicator = Indicator.shared
    var body: some View {
        MobbinNavigationView {
            switch indicator.platform {
            case .ios:
                iOSListView()
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
