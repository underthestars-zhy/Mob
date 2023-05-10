//
//  MobbinNavigationBar.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI
import VisualEffectView

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
                        .opacity((viewModel.exntend && viewModel.stage == .normal) ? 0 : 1)
                }
                .padding(.horizontal, viewModel.stage == .normal ? 30 : 35)
                .padding(.bottom, viewModel.stage == .minimal ? 20 : 0)

                if viewModel.stage != .normal && viewModel.exntend {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            if viewModel.platform != Platform.ios {
                                MobbinPlatformPicker(largeTitle: false, platform: .ios, currentPlatform: $viewModel.platform)
                            }

                            if viewModel.platform != Platform.android {
                                MobbinPlatformPicker(largeTitle: false, platform: .android, currentPlatform: $viewModel.platform)
                            }

                            if viewModel.platform != Platform.web {
                                MobbinPlatformPicker(largeTitle: false, platform: .web, currentPlatform: $viewModel.platform)
                            }
                        }

                        Spacer()
                    }
                    .padding(.top, viewModel.stage == .smallHead ? 20 : 0)
                    .padding(.horizontal, 35)
                    .padding(.bottom, 10)
                }

                if viewModel.stage != .minimal || viewModel.exntend {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            MobbinSectionButton(section: .apps, currentSection: $viewModel.currentSection)
                                .padding(.leading, 20)

                            MobbinSectionButton(section: .screens, currentSection: $viewModel.currentSection)

                            MobbinSectionButton(section: .flows, currentSection: $viewModel.currentSection)

                            Spacer()
                        }
                    }
                    .padding(.top, 20)
                    .opacity((viewModel.exntend && viewModel.stage == .normal) ? 0 : 1)
                    .padding(.bottom, (viewModel.stage != .normal && viewModel.exntend) ? 20 : 0)
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
                    VisualEffect(colorTint: .white, colorTintAlpha: 0.8, blurRadius: 15)
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

