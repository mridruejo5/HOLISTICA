//
//  LoginView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 21/10/23.
//

import SwiftUI
import MRNetwork
import AuthenticationServices

struct LoginView: View {
    
    @Binding var showLogin:Bool
    
    @State var showRegister = false
    @State var showRegisterSIWA = false
    
    @State var user = ""
    @State var pass = ""
    
    @State var showAlert = false
    @State var message = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Login")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
            
            Divider()
                .background(Color.charcoal)
                .padding(.bottom)

            Text("Username (email)")
            TextField("Enter your username", text: $user)
                .textContentType(.username)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            Text("Password")
                .padding(.top)
            TextField("Enter your password", text: $pass)
                .textContentType(.password)
            
            Button {
                Task {
                    do {
                        try await Network.shared.loginUser(user: user, password: pass)
                        showLogin = !SecManager.shared.isUserLogged()
                    } catch let error as NetworkError {
                        pass = ""
                        message = error.description
                        showAlert.toggle()
                    } catch {
                        pass = ""
                        message = error.localizedDescription
                        showAlert.toggle()
                    }
                }
            }
        label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.charcoal)
            .padding(.top, 10)
            
            
            Text("- or - ")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
            
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
            .frame(height: 35)
            
            Button {
                showRegister.toggle()
            } label: {
                Text("Press to Register")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
            }
                
            .alert("User login error", isPresented: $showAlert) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { Text("Ok") })
            } message: {
                Text(message)
            }
        }
            
            
        Text("Copyright 2023 – holistica.es")
                .font(.footnote)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
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
        
        .fullScreenCover(isPresented: $showRegister) {
            RegisterView(showRegister: $showRegister, showLogin: $showLogin)
                .frame(alignment: .top)
        }
    }
}

#Preview {
    LoginView(showLogin: .constant(true))
}
