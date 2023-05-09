//
//  MobbinAvatarView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI
import MobbinAPI

struct MobbinAvatarView: View {
    @EnvironmentObject var viewModel: NavigationViewModel

    @State var userInfo: UserInfo? = nil

    var body: some View {
        VStack(spacing: 0) {
            if let userInfo {
                AsyncImage(url: userInfo.avatarUrl) {image in
                    image.image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: viewModel.stage == .normal ? 40 : 32)
                        .clipShape(Circle())
                }
            } else {
                VStack {
                    
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut) {
                userInfo = try? MobbinManager.shared.mobbinAPI.retrieveUserInfo()
            }
        }
    }
}
