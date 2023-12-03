//
//  SettingsView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 19/11/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var loginVM:LoginVM
    
    @State var showAlert = false
    
    var body: some View {
        List {
            if SecManager.shared.biometry != .none {
                Toggle(isOn: $loginVM.biometry) {
                    Label(loginVM.getBiometryText(),
                          systemImage: loginVM.getBiometryImage())
                }
                .toggleStyle(.switch)
                .padding()
            }
            Text("Privacy Policy")
            Text("Terms of Service")
            Text("About us")
            
            Button {
                showAlert.toggle()
            } label: {
                Text("Log out")
            }
            .buttonStyle(.borderless)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .listStyle(.inset)
        
        .alert("Are you sure you wish to log out?",
               isPresented: $showAlert) {
            Button {
                loginVM.logout()
            } label: {
                Text("Log out")
            }
            Button(role: .cancel) {
                
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LoginVM())
}
