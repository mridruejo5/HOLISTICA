//
//  LoginRegisterN.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//


import SwiftUI

struct LoginRegisterView: View {
    @Binding var showLogin:Bool
    
    var body: some View {
        Group {
            VStack {
                Image("FotoYoga2x")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .ignoresSafeArea()
                    .overlay {
                        Rectangle()
                            .foregroundStyle(Color.charcoal)
                            .opacity(0.8)
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
                }
            }
            LoginView(showLogin: $showLogin)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    LoginRegisterView(showLogin: .constant(true))
}
