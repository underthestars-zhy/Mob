//
//  MobbinNavigationView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI
import SwiftUIX
import VisualEffectView

struct MobbinNavigationView<Content: View>: View {
    @StateObject var viewModel = NavigationViewModel()

    @ViewBuilder let content: (Indicator) -> Content

    @State var barHeight: CGFloat = .zero
    @State var scrollValue: CGPoint = .zero

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Color.clear
                        .frame(height: barHeight)

                    VStack(spacing: 0) {
                        content(Indicator(platform: viewModel.platform, section: viewModel.currentSection))
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                }
                .measureScroll { scroll in
                    scrollValue = scroll
                }
                .onChange(of: scrollValue) { value in
                    withAnimation(.easeInOut) {
                        if value.y <= 0 {
                            switch abs(value.y) {
                            case 45...:
                                viewModel.stage = .minimal
                            case 20..<45:
                                viewModel.stage = .smallHead
                            case 0..<20:
                                viewModel.stage = .normal
                            default:
                                viewModel.stage = .normal
                            }
                        } else {
                            viewModel.stage = .normal
                        }
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        }
        .overlay {
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        MobbinPlatformPicker(largeTitle: viewModel.stage == .normal, platform: .ios, currentPlatform: $viewModel.platform)

                        MobbinPlatformPicker(largeTitle: viewModel.stage == .normal, platform: .android, currentPlatform: $viewModel.platform)

                        MobbinPlatformPicker(largeTitle: viewModel.stage == .normal, platform: .web, currentPlatform: $viewModel.platform)
                    }

                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.top, 160)

                Spacer()
            }
            .animation(.easeInOut(duration: 2), value: viewModel.exntend)
            .frame(maxWidth: Screen.width, maxHeight: Screen.height)
            .background(VisualEffect(colorTint: .white, colorTintAlpha: 0.8, blurRadius: 20))
            .opacity(viewModel.exntend ? 1 : 0)
        }
        .overlay(MobbinNavigationBar(barHeight: $barHeight))
        .frame(maxWidth: .infinity)
        .environmentObject(viewModel)
    }
}

struct MobbinNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MobbinNavigationView { indicator in
            VStack {
                ForEach(1..<50, id: \.self) { _ in
                    Text("hi")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
