//
//  MobbinNavFloatBar.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/15.
//

import SwiftUI

struct MobbinNavFloatBar: View {
    @EnvironmentObject var viewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Spacer()

            HStack {
                if viewModel.stage == .normal {
                    VStack {}
                        .frame(width: 44)
                    Spacer()
                }

                MobbinFloatSearchItem(extend: viewModel.stage == .normal) {

                }

                Spacer()

                MobbinFloatFilterItem(extend: viewModel.stage != .normal) {

                }

                if viewModel.stage != .normal {
                    Spacer()

                    MobbinFloatReachTopItem {
                        viewModel.uikitScrollView?.scrollToTop()
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 130)
        }
    }
}
