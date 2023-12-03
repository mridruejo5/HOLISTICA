//
//  BiometryLogin.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 29/10/23.
//

import SwiftUI

struct BiometryLogin: View {
    @EnvironmentObject var loginVM:LoginVM

    var body: some View {
        VStack {
            Button {
                Task {
                    await loginVM.checkBiometry()
                }
            } label: {
                Image(systemName: SecManager.shared.biometry == .touchID ? "touchid" : "faceid")
                    .font(.largeTitle)
                    .controlSize(.large)
            }
            .buttonStyle(.bordered)
            
            Button {
                loginVM.showBiometry = false
                loginVM.logout()
            } label: {
                Text("I'm not \(loginVM.userInfo?.name ?? "")")
            }
            .padding(.top)
        }
        .padding()
        .background {
            Color(white: 0.95)
        }
        .cornerRadius(10)
        .shadow(color: .primary.opacity(0.3), radius: 5, x: 3, y: 3)
        .padding()
    }
}

#Preview {
    BiometryLogin()
        .environmentObject(LoginVM())
}
