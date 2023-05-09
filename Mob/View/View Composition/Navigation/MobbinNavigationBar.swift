//
//  MobbinNavigationBar.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI

struct MobbinNavigationBar: View {
    @EnvironmentObject var viewModel: NavigationViewModel

    @Binding var barHeight: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    MobbinPlatformSwitcher(largeTitle: viewModel.stage == .normal, platform: $viewModel.platform, extend: $viewModel.exntend)

                    Spacer()

                    MobbinAvatarView()
                        .transition(.opacity.animation(.easeInOut))
                        .opacity(viewModel.exntend ? 0 : 1)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, viewModel.stage == .minimal ? 20 : 0)
                

                if viewModel.stage != .minimal {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            MobbinSectionButton(section: .apps, currentSection: $viewModel.currentSection)

                            MobbinSectionButton(section: .screens, currentSection: $viewModel.currentSection)

                            MobbinSectionButton(section: .flows, currentSection: $viewModel.currentSection)

                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .transition(.opacity.animation(.easeInOut))
                    .opacity(viewModel.exntend ? 0 : 1)
                }
            }
            .padding(.top, viewModel.stage == .normal ? 70 : 58)
            .overlay {
                Color.clear
                    .measureSize { size in
                        if viewModel.stage == .normal {
                            barHeight = size.height
                        }
                    }
            }
            .background(Group {
                if viewModel.stage == .minimal {
                    Color.white.opacity(0.8).background(.ultraThinMaterial)
                } else {
                    Color.clear
                }
            })

            Spacer()
        }
    }
}

struct MobbinNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        MobbinNavigationBar(barHeight: .constant(0))
            .environmentObject(NavigationViewModel())
            .edgesIgnoringSafeArea(.all)
    }
}

