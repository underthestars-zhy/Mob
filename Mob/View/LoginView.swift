//
//  LoginView.swift
//  Mob
//
//  Created by 朱浩宇 on 2023/5/1.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    @FocusState var inputVerifyCode: Bool

    var body: some View {
        KeyboardBackground {
            VStack(spacing: 0) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                    .padding(.top, 100)

                Text("Login to Mobbin")
                    .font(.system(size: 36, weight: .heavy))
                    .padding(.top, 30)

                VStack(spacing: 0) {
                    if !inputVerifyCode {
                        TextfieldSection(section: "Email", prompt: "Enter email adress", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .onChange(of: viewModel.email) { _ in
                                viewModel.emailSent = false
                                viewModel.status = .nothing
                            }
                            .disabled(viewModel.status != .nothing)
                    }

                    if viewModel.emailSent {
                        if !inputVerifyCode {
                            Text("We sent you a temporary login code.\nPlease check your inbox.")
                                .lineLimit(2...)
                                .font(.system(size: 14, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .padding(.top, 20)
                        }

                        TextfieldSection(section: "Login Code", prompt: "Paste login code", text: $viewModel.code)
                            .focused($inputVerifyCode)
                            .keyboardType(.numberPad)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(.top, inputVerifyCode ? 0 : 30)
                            .disabled(viewModel.status != .nothing)
                    }

                    VStack(spacing: 0) {
                        switch viewModel.status {
                        case .nothing:
                            MobbinTextButton(text: viewModel.emailSent ? "Continue" : "Continue with email") {
                                if viewModel.emailSent {
                                    viewModel.verifyCode()
                                } else {
                                    viewModel.sendEmail()
                                }
                            }
                        case .verify:
                            MobbinStatusButton {
                                CircleProgressView()
                                    .frame(width: 20, height: 20)
                            }
                        case .success:
                            MobbinStatusButton {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(hexadecimal: "151515"))
                                    .font(.system(size: 24, weight: .semibold))
                            }
                        }

                    }
                    .padding(.top, 40)
                    .animation(.easeInOut, value: viewModel.status)
                }
                .padding(.top, 50)
                .padding(.horizontal, 30)

                Spacer()
            }
        }
    }

    struct TextfieldSection: View {
        let section: String
        let prompt: String
        @Binding var text: String

        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text(section)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.leading, 8)

                    Spacer()
                }

                MobbinTextField(prompt: prompt, text: $text)
                    .padding(.top, 15)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
