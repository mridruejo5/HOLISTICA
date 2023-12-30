//
//  LoginRegisterN.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//


import SwiftUI

struct LoginRegisterView: View {
    @Binding var showLogin:Bool
    
    let loginSIWAOK = NotificationCenter.default
        .publisher(for: .loginSIWAOK)
        .receive(on: DispatchQueue.main)
    
    var body: some View {
        Group {
            VStack(spacing: 0) {
                Image("FotoYoga2x")
                    .resizable()
                    .frame(height: 350)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(Color.charcoal)
                            .opacity(0.5)
                            .ignoresSafeArea()
                    }
                .overlay {
                    VStack {
                        Image("Logotipo_BN_blanco2x")
                        Text("Bienvenido a la escuela")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.bottom, 25)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 30)
                }
            }
            .offset(y: -40)
            LoginView(showLogin: $showLogin)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .offset(y: -47)
        }
        .onReceive(loginSIWAOK) { _ in
            showLogin = false
        }
    }
}

#Preview {
    LoginRegisterView(showLogin: .constant(true))
}
