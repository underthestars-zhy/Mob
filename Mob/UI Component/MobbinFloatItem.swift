//
//  MobbinFloatItem.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/13.
//

import SwiftUI

struct MobbinFloatItem<Full: View, Compress: View>: View {
    let extend: Bool
    let action: () -> ()

    let full: Full
    let compress: Compress

    init(extend: Bool, action: @escaping () -> (), @ViewBuilder full: () -> Full, @ViewBuilder compress: () -> Compress) {
        self.extend = extend
        self.action = action
        self.full = full()
        self.compress = compress()
    }

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if extend {
                    HStack {
                        full
                    }
                    .padding(.horizontal, 15)
                } else {
                    HStack {
                        compress
                    }
                    .frame(width: 44)
                }
            }
            .frame(height: 44)
            .background(.black)
            .cornerRadius(22)
        }
    }
}


struct MobbinFloatSearchItem: View {
    let extend: Bool
    let action: () -> ()

    var body: some View {
        MobbinFloatItem(extend: extend, action: action) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundColor(.white)

                Text("Search")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
        } compress: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 21, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct MobbinFloatReachTopItem: View {
    let action: () -> ()

    var body: some View {
        MobbinFloatItem(extend: false, action: action) {
            EmptyView()
        } compress: {
            Image(systemName: "arrow.up")
                .font(.system(size: 23, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct MobbinFloatFilterItem: View {
    let extend: Bool
    let action: () -> ()

    var body: some View {
        MobbinFloatItem(extend: extend, action: action) {
            HStack(spacing: 6) {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)

                Text("Filters")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
        } compress: {
            Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
