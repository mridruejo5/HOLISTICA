//
//  SIWAView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 23/12/23.
//

import SwiftUI
import AuthenticationServices

struct SIWAView: View {
    @EnvironmentObject var loginVM:LoginVM
    
    @Binding var showRegisterSIWA:Bool
    @Binding var showLogin:Bool
    
    @State var showAlert = false
    @State var message = ""
    
    var body: some View {
        
        VStack {
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
                switch result {
                case .success(let authResult):
                    SecManager.shared.SIWACredentials(credential: authResult.credential)
                case .failure(let error):
                    message = "Sign in error: \(error.localizedDescription)"
                    showAlert.toggle()
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            

            Button {
                showRegisterSIWA.toggle()
            } label: {
                Text("I already have an account")
                    .font(.callout)
                    .frame(alignment: .trailing)
                    .padding(.top)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 560, alignment: .bottom)
        .aspectRatio(contentMode: .fill)
        .background {
            Color.sand
                .opacity(0.7)
        }
        .cornerRadius(10)
        .textFieldStyle(.roundedBorder)
        
        .alert("User login error", isPresented: $showAlert) {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { Text("Ok") })
        } message: {
            Text(message)
        }
    }
}

#Preview {
    SIWAView(showRegisterSIWA: .constant(true), showLogin: .constant(false))
}
