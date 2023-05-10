//
//  MobbinSectionButton.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/8.
//

import SwiftUI

struct MobbinSectionButton: View {
    let section: Section
    @Binding var currentSection: Section

    @State var value: String? = nil

    var body: some View {
        MobbinButton {
            if currentSection == section {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(section.displayText)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)

                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(Color(hexadecimal: "989898"))
                            .padding(.horizontal, 8)

                        Text(value ?? "???")
                            .foregroundColor(Color(hexadecimal: "989898"))
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .background(Color(hexadecimal: "151515"))
                .cornerRadius(8)
            } else {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(section.displayText)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)

                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(Color(hexadecimal: "989898"))
                            .padding(.horizontal, 8)

                        Text(value ?? "???")
                            .foregroundColor(Color(hexadecimal: "989898"))
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
            }
        } hoverView: {
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(section.displayText)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)

                    Rectangle()
                        .frame(width: 1, height: 16)
                        .foregroundColor(Color(hexadecimal: "989898"))
                        .padding(.horizontal, 8)

                    Text(value ?? "???")
                        .foregroundColor(Color(hexadecimal: "989898"))
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            .background(Color(hexadecimal: "EDEDED"))
            .cornerRadius(8)
        } action: {
            withAnimation(.easeInOut) {
                currentSection = section
            }
        }
        .animation(.easeInOut, value: value)
        .task {
            do {
                let mobbinAPi = MobbinManager.shared.mobbinAPI
                switch section {
                case .apps:
                    value = "\(try await mobbinAPi.iOSAppsCount)"
                case .screens:
                    value = "\(try await mobbinAPi.iOSScreensCount)"
                case .flows:
                    value = "\(try await mobbinAPi.iOSFlowCount)"
                }
            } catch {
                print(error)
            }
        }
    }
}

struct MobbinSectionButton_Previews: PreviewProvider {
    static var previews: some View {
        MobbinSectionButton(section: .apps, currentSection: .constant(.apps))

        MobbinSectionButton(section: .flows, currentSection: .constant(.apps))
    }
}
