//
//  MobbinTabView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/11.
//

import SwiftUI
import Introspect

struct MobbinTabView<BrowseView: View, CollectionView: View>: View {
    @ViewBuilder var browseView: () -> BrowseView
    @ViewBuilder var collectionView: () -> CollectionView

    @State var selection = TabState.browse

    enum TabState {
        case browse
        case collection
    }

    var body: some View {
        TabView(selection: $selection) {
            browseView()
                .edgesIgnoringSafeArea(.all)
                .tag(TabState.browse)

            collectionView()
                .edgesIgnoringSafeArea(.all)
                .tag(TabState.collection)
        }
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
        }
    }
}
