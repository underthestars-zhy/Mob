//
//  MobbinTabView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/11.
//

import SwiftUI
import SwiftUIX
import Introspect

struct MobbinTabView<BrowseView: View, CollectionView: View>: View {
    @StateObject var viewModel = TabViewModel()

    @ViewBuilder var browseView: () -> BrowseView
    @ViewBuilder var collectionView: () -> CollectionView

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            browseView()
                .tag(TabViewModel.TabStatus.browse)

            collectionView()
                .tag(TabViewModel.TabStatus.collections)
        }
        .introspectTabBarController {
            $0.tabBar.isHidden = true
        }
        .edgesIgnoringSafeArea(.all)
        .overlay {
            VStack {
                Spacer()

                VStack(spacing: 0) {
                    Spacer()

                    HStack(alignment: .top, spacing: 0) {
                        TabBarItem(tab: .browse, current: $viewModel.currentTab)
                            .padding(.leading, 82)

                        Spacer()

                        TabBarItem(tab: .collections, current: $viewModel.currentTab)
                            .padding(.trailing, 64)
                    }
                    .padding(.bottom, 45)
                }
                .frame(width: Screen.main.width, height: 110)
                .background(.black)
                .clipShape(TopRoundedRectangle(cornerRadius: 25))
                .opacity(viewModel.tabBarStage == .ignore ? 0 : 1)
                .animation(.easeOut, value: viewModel.tabBarStage)
            }
        }
        .environmentObject(viewModel)
    }
}
