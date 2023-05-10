//
//  MobbinNavigationView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI
import SwiftUIX
import VisualEffectView
import Introspect

struct MobbinNavigationView<Content: View>: View {
    @StateObject var viewModel = NavigationViewModel()
    @StateObject var scrollViewDelegate = MobbinScrollViewDelegate()

    @ViewBuilder let content: () -> Content

    @State var barHeight: CGFloat = .zero
    @State var scrollValue: CGPoint = .zero

    @State private var isScrolling = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack {}
                        .frame(height: barHeight)

                    VStack(spacing: 0) {
                        content()
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 30)
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

                        if viewModel.exntend && viewModel.stage != .normal && scrollViewDelegate.isScrolling {
                            viewModel.exntend = false
                        }
                    }
                }
                .onChange(of: isScrolling, perform: { value in
                    print(value)
                })
            }
            .introspectScrollView { uiScrollView in
                uiScrollView.delegate = scrollViewDelegate
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
            .background(VisualEffect(colorTint: .white, colorTintAlpha: 0.8, blurRadius: 20).onTapGesture {
                withAnimation(.easeInOut) {
                    viewModel.exntend = false
                }
            })
            .opacity((viewModel.exntend && viewModel.stage == .normal) ? 1 : 0)
        }
        .overlay(MobbinNavigationBar(barHeight: $barHeight))
        .frame(maxWidth: .infinity)
        .environmentObject(viewModel)
    }
}

struct MobbinNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MobbinNavigationView {
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
