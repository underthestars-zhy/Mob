//
//  ListView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()

    @ObservedObject var indicator: Indicator = Indicator.shared
    
    var body: some View {
        VStack {
            if viewModel.apps.isEmpty {
                LoadingView()
            } else {
                LazyVStack(spacing: 30) {
                    ForEach(viewModel.apps) { app in
                        AppListItem(app: app)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            viewModel.fetchApps()
        }
        .onChange(of: indicator.platform) { _ in
            viewModel.fetchApps()
        }
        .onChange(of: indicator.section) { _ in
            viewModel.fetchApps()
        }
        .onChange(of: indicator.onBottom) { _ in
            viewModel.updateApps()
        }
        .animation(nil, value: indicator.section)
    }
}
