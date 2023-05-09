//
//  MobbinNavigationView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI

struct MobbinNavigationView<Content: View>: View {
    @StateObject var viewModel = NavigationViewModel()

    @ViewBuilder let content: () -> Content

    @State var barHeight: CGFloat = .zero
    @State var scrollValue: CGPoint = .zero

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Color.clear
                        .frame(height: barHeight)

                    Text("\(scrollValue.y)")
                        .padding(.top, 30)

                    content()
                        .padding(.horizontal, 20)

                }
                .measureScroll { scroll in
                    scrollValue = scroll
                }
                .onChange(of: scrollValue) { value in
                    withAnimation(.easeInOut) {
                        if value.y <= -10 {
                            viewModel.stage = .smallHead
                        } else if value.y >= -30 {
                            viewModel.stage = .normal
                        }
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
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
