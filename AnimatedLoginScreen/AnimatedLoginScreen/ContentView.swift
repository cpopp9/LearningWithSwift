//
//  ContentView.swift
//  AnimatedLoginScreen
//
//  Created by Cory Popp on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    
    @FocusState private var focusField: FocusableField?
    
    @State private var loginState: LoginState = .loggedOut
    
    private enum FocusableField {
        case username, password
    }
    
    private enum LoginState {
        case loggedOut, loggingIn, loggedIn
    }
    
    private var passwordStrength: CGFloat {
        CGFloat(password.count) / 8
    }
    
    private var passwordFieldColor: Color {
        switch password.count {
        case 0:
            return .gray
        case 1...7:
            return .red
        default:
            return .green
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                buildUsernameTextfield()
                buildPasswordSecurefield()
                buildLoginButton()
            }
            .padding()
            .navigationTitle("Login")
        }
        .onAppear(perform: assignFirstFocus)
        .onSubmit(assignNextFocusField)
    }
    
    func assignFirstFocus() {
        focusField = .username
    }
    
    func assignNextFocusField() {
        switch focusField {
        case .username:
            focusField = .password
        case .password:
            focusField = nil
        case nil:
            break
        }
    }
    
    @ViewBuilder
    private func buildUsernameTextfield() -> some View {
        TextField("username", text: $userName)
            .padding()
            .background {
                Color.gray.opacity(0.1)
                    .cornerRadius(10)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: focusField == .username ? 1 : 0)
            )
            .focused($focusField, equals: .username)
    }
    
    @ViewBuilder
    private func buildPasswordSecurefield() -> some View {
        SecureField("password", text: $password)
            .padding()
            .background {
                Color.gray.opacity(0.1)
                    .cornerRadius(10)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(passwordFieldColor, lineWidth: focusField == .password ? 1 : 0)
                
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.ultraThinMaterial, lineWidth: 5)
                        
                        Circle()
                            .trim(from: 0, to: passwordStrength)
                            .stroke(passwordFieldColor.gradient, lineWidth: 5)
                            .rotationEffect(.init(degrees: -90))
                            .animation(.easeIn, value: passwordStrength)
                    }
                    .frame(width: 20, height: 20)
                }
                .padding()
            }
            .focused($focusField, equals: .password)
    }
    
    @ViewBuilder
    private func buildLoginButton() -> some View {
        Button() {
            Task {
                await initiateLogin()
            }
        } label: {
            switch loginState {
            case .loggedOut:
                Text("Login")
                    .foregroundStyle(.white)
            case .loggingIn:
                ProgressView()
                    .tint(.white)
            case .loggedIn:
                Text("👍")
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.green)
        .cornerRadius(10)
        .padding(.top, 50)
    }
    
    private func initiateLogin() async {
        loginState = .loggingIn
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        loginState = .loggedIn
    }
}

#Preview {
    ContentView()
}
