//
//  iOSListView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/10.
//

import SwiftUI

struct iOSListView: View {
    let indicator: Indicator

    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        if viewModel.apps.isEmpty {
            LoadingView()
                .onAppear {
                    viewModel.fetchApps(indicator)
                }
        } else {
            VStack(spacing: 30) {
                ForEach(viewModel.apps) { app in
                    AppListItem(app: app)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
